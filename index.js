require("dotenv").config();
const Discord = require("discord.js");
const fs = require("fs");
const { REST } = require("@discordjs/rest");
const { Routes } = require("discord-api-types/v9");
const { Player } = require("discord-player");
const { promisify } = require("util");

const TOKEN = process.env.TOKEN,
  APPLICATION_ID = process.env.APPLICATION_ID;

const client = new Discord.Client({
  intents: ["GUILDS", "GUILD_VOICE_STATES"],
});

client.slashcommands = new Discord.Collection();
client.player = new Player(client, {
  ytdlOptions: {
    quality: "highestaudio",
    highWaterMark: 1 << 25,
  },
});

const deploySlashCommand = promisify(() => {
  const slashFiles = fs.readdirSync(`${__dirname}/slash`).filter((file) => file.endsWith(".js"));
  let commands = [];
  for (const file of slashFiles) {
    const slashcmd = require(`${__dirname}/slash/${file}`);
    client.slashcommands.set(slashcmd.data.name, slashcmd);
    commands.push(slashcmd.data.toJSON());
  }
  const rest = new REST({ version: "9" }).setToken(TOKEN);
  console.log("deploying slash commands");
  rest
    .put(Routes.applicationCommands(APPLICATION_ID), { body: commands })
    .then(() => console.log("registering slash commands globally"))
    .catch(() => console.log("failed to deploy slash command"));
});
(async () => await deploySlashCommand())();

client.on("ready", () => {
  console.log(`Logged in as ${client.user.tag}`);
});

client.on("interactionCreate", async (interaction) => {
  if (!interaction.isCommand()) return;

  const slashcmd = client.slashcommands.get(interaction.commandName);
  if (!slashcmd) interaction.reply("Not a valid slash command");

  await interaction.deferReply();
  await slashcmd.run({ client, interaction });
});

client.on("error", (err) => {
  console.error(err);
  console.error(err.message);
});

client.login(TOKEN);

# kbot - A Telegram Bot in Go

![GitHub](https://img.shields.io/github/license/ukrsite/kbot)

## Overview

`kbot` is a simple Telegram bot written in Go using the Telebot library. It responds to various commands and serves as an example of building a basic Telegram bot using Go.

## Features

- Greet users with a "hello" command
- Provide the bot's version with a "version" command
- Say goodbye with a "bye" command
- Handle invalid commands gracefully

## Installation

### Prerequisites

- Go installed on your machine
- Telegram Bot Token (obtained from [BotFather](https://t.me/botfather))

### Steps

1. Clone the repository:

   git clone https://github.com/ukrsite/kbot.git
   cd your-repo

2. Set the Telegram Bot Token as an environment variable:

    export TELE_TOKEN=your-telegram-bot-token

3. Run the bot:

    go run main.go kbot

## Usage

To interact with the bot, open your Telegram app and search for @ukrsite_bot. Start a chat and try the following commands:

/hello: Greet the bot

/version: Get the bot's version

/bye: Say goodbye

Any other command: Receive an "Invalid command" response

Feel free to modify and extend the bot's functionality according to your needs.

## GitHub Actions Workflow


## License

This project is licensed under the MIT License - see the LICENSE file for details.

FROM node:18-alpine

RUN apk add --no-cache unzip && npm install -g pnpm

WORKDIR /app

COPY botcontrol.zip .
RUN unzip -o botcontrol.zip && rm botcontrol.zip

# Install dependencies and run the bot
WORKDIR /app/bot
RUN pnpm install

CMD ["pnpm", "start"]

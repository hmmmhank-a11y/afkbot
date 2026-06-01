FROM node:18-alpine

RUN apk add --no-cache unzip && npm install -g pnpm

WORKDIR /app

COPY botcontrol.zip .
RUN unzip -o botcontrol.zip && rm botcontrol.zip

# Install dependencies and start the bot
WORKDIR /app/bot
RUN pnpm install

# Build the dashboard
WORKDIR /app/dashboard
RUN pnpm install
RUN pnpm run build

# Run the bot
WORKDIR /app/bot
CMD ["pnpm", "start"]

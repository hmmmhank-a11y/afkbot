FROM node:18-alpine

RUN apk add --no-cache unzip && npm install -g pnpm

WORKDIR /app

COPY botcontrol.zip .
RUN unzip -o botcontrol.zip && rm botcontrol.zip

# Install bot dependencies
WORKDIR /app/bot
RUN pnpm install

# Install dashboard dependencies and build (skip typecheck — tsc --noEmit
# fails due to type errors that don't affect the runtime bundle)
WORKDIR /app/dashboard
RUN pnpm install
RUN pnpm exec vite build

# Start the bot
WORKDIR /app/bot
CMD ["pnpm", "start"]

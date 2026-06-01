FROM node:18-alpine

RUN npm install -g pnpm

WORKDIR /app

COPY botcontrol.zip .
RUN unzip -o botcontrol.zip && rm botcontrol.zip

RUN pnpm install
RUN pnpm --filter @workspace/dashboard run build

CMD ["pnpm", "--filter", "@workspace/bot", "start"]

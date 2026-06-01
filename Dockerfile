FROM node:18-alpine

RUN apk add --no-cache unzip && npm install -g pnpm

WORKDIR /app

COPY botcontrol.zip .
RUN unzip -o botcontrol.zip && rm botcontrol.zip

WORKDIR /app/bot
RUN pnpm install

CMD node artifacts/api-server/dist/index.js || node dist/index.js || node index.js

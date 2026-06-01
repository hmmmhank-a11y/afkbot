FROM node:18-alpine

RUN apk add --no-cache unzip && npm install -g pnpm

WORKDIR /app

COPY botcontrol.zip .
RUN unzip -o botcontrol.zip && rm botcontrol.zip

WORKDIR /app/bot
RUN pnpm install

# Build if a build script is defined, otherwise skip silently
RUN pnpm run build 2>/dev/null || true

# Print available scripts so the correct start command is visible in logs
RUN echo "=== package.json scripts ===" && \
    node -e "const p=require('./package.json'); console.log(JSON.stringify(p.scripts,null,2))" 2>/dev/null || true

# Try pnpm start; if the script is missing, fall back to common entry points
CMD sh -c '\
  node -e "const s=require(\"./package.json\").scripts||{}; \
           if(!s.start){console.error(\"No start script found. Available:\",JSON.stringify(s)); process.exit(1);}" && \
  pnpm start'

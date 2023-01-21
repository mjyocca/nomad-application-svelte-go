FROM node:16.14 AS build
RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm
WORKDIR /app
COPY . .
RUN pnpm install
RUN pnpm build

FROM node:16.14 AS node-server
RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm
WORKDIR /app
RUN rm -rf ./*
COPY --from=build /app/package.json .
COPY --from=build /app/pnpm-lock.yaml .
COPY --from=build /app/build .
RUN pnpm install --frozen-lockfile --prod
EXPOSE 3000
CMD ["node", "index.js"]
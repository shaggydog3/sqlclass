FROM node:alpine
WORKDIR "/app"
COPY web/package.json .
RUN npm install
COPY . .
CMD ["npm", "run", "start"]
FROM arm32v7/node:14-stretch-slim as build
WORKDIR angular-app
COPY package.json package-lock.json ./
RUN echo "Running inital install for dependency cache"
RUN npm install
COPY . .
RUN echo "Running build"
RUN npm run build

FROM arm32v7/nginx:1.21-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build angular-app/dist/meal-planner-fe-v2 /usr/share/nginx/html
RUN echo "Done!"

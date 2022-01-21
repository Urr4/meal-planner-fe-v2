FROM node:erbium-alpine3.14 as build
WORKDIR angular-app
COPY package.json package-lock.json ./
RUN echo "Running inital install for dependency cache"
RUN npm install -timeout=600000
COPY . .
RUN echo "Running build"
RUN npm run build

FROM nginx:1.21.1
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build angular-app/dist/meal-planner-fe /usr/share/nginx/html
RUN echo "Done!"

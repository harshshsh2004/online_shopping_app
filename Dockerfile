# # Build stage
# FROM node:20-alpine as build
# WORKDIR /app
# #COPY package*.json ./
# COPY /public .
# COPY . .
# RUN npm install

# RUN npm run build

# # Production stage with Nginx
# FROM nginx:alpine
# COPY --from=build /app/dist /usr/share/nginx/html
# #COPY nginx.conf /etc/nginx/conf.d/default.conf
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# ===== Build Stage =====
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files first for caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the files
COPY . .

# Build the React app
RUN npm run build

# ===== Production Stage =====
FROM nginx:alpine

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy build output from previous stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
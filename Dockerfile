# Use the NGINX base image
FROM nginx:latest

# Copy the application files to the NGINX html directory
COPY server.js /usr/share/nginx/html/
COPY package.json /usr/share/nginx/html/

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Default command to keep NGINX running
CMD ["nginx", "-g", "daemon off;"]


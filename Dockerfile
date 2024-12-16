se a Node.js base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy the application code
COPY . .

# Expose the application port
EXPOSE 8080

# Define the default command
CMD ["node", "server.js"]


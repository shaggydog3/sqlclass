# This file is just to keep one line commands I was using when getting the
# node and mysql containers up, and talking to each other.
# Build the container
docker build -t sqlclass .
# run the container and connect to the network where mysql is running
# (from the docker compose).
#docker run -v /app/node_modules --network="sqlclass_default"-v $(pwd):/app -p 8080:8080 sqlclass

# Revised, as I moved the app into a subfolder off root:
docker run -v /app/node_modules --network="sqlclass_default" -v $(pwd)/web:/app -p 8080:8080 sqlclass

# test user to determine if it's vulnerable to sql injection.
# gooduser4@gmail.com\');INSERT INTO users (email) VALUES("baduser4@gmail.com");
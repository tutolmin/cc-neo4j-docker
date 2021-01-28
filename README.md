# cc-neo4j-docker

# Create home directory for chess project
cd /home/chesscheat/

# Clone the custom Neo4j Dockerfile
git clone git@github.com:tutolmin/cc-neo4j-docker.git

# Build a new image using Dockerfile
docker build cc-neo4j-docker -t cc-neo4j:v1

# Decide which DB to restore on a first run
https://github.com/tutolmin/dbdump/branches

# Run a command to create a named container 
docker run     --name cc-neo4j     -p7474:7474 -p7687:7687     -d     -v $NEO4J_HOME/logs:/logs     -v $NEO4J_HOME/import:/var/lib/neo4j/import     -e DBDUMP=tutolmin     cc-neo4j:v1

# Start the new container
docker start cc-neo4j

# check the startup logs
docker logs cc-neo4j

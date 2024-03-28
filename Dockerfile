# Use a base image with GCC and gprof installed
FROM gcc:latest

# set.mm: shallow clone
WORKDIR /
RUN git clone --depth 1 https://github.com/metamath/set.mm.git

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY checkmm.cpp checkmm.cpp

# Compile the C++ code with debugging symbols and enable profiling
RUN g++ -g -pg -o checkmm checkmm.cpp

# Run the program to generate profiling data
RUN ./checkmm /set.mm/set.mm

# When run, generate profiling information
CMD ["gprof", "checkmm"]

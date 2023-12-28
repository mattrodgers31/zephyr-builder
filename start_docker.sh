docker run \
	-v $(pwd):/workdir/project \
    -v ~/zephyrproject:/workdir/zephyrproject \
	-w /workdir/project \
	-it --rm zephyr-builder /bin/bash

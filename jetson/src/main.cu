#include <iostream>
#include <cuda_runtime.h>

// CUDA Kernel function to print "Hello, CUDA!" from each thread
__global__ void helloCUDA()
{
    printf("Hello, CUDA! from thread %d\n", threadIdx.x);
}

int main()
{
    // Launch the helloCUDA kernel with 1 block and 10 threads per block
    helloCUDA<<<1, 10>>>();

    // Wait for the GPU to finish
    cudaDeviceSynchronize();
	
	cudaError_t cudaError = cudaGetLastError();
    if (cudaError != cudaSuccess)
    {
        std::cerr << "CUDA error: " << cudaGetErrorString(cudaError) << std::endl;
        return 1;
    }

    std::cout << "CUDA kernel executed successfully!" << std::endl;

    // Print a message from the CPU
    std::cout << "Hello from CPU!" << std::endl;

    return 0;
}

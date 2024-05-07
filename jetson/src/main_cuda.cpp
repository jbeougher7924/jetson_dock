#include <iostream>
#include <cuda_runtime.h>

// CUDA kernel to print "Hello, CUDA!" from each thread
__global__ void helloCUDA()
{
    printf("Hello, CUDA!\n");
}

int main()
{
    // Launch CUDA kernel with 1 block and 1 thread per block
    helloCUDA<<<1, 1>>>();

    // Synchronize threads and check for CUDA errors
    cudaDeviceSynchronize();
    cudaError_t cudaError = cudaGetLastError();
    if (cudaError != cudaSuccess)
    {
        std::cerr << "CUDA error: " << cudaGetErrorString(cudaError) << std::endl;
        return 1;
    }

    std::cout << "CUDA kernel executed successfully!" << std::endl;

    return 0;
}

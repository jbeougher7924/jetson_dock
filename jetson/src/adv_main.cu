#include <iostream>
#include <cuda_runtime.h>

// CUDA Kernel function to add two arrays element-wise
__global__ void addArrays(float *a, float *b, float *c, int size)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < size)
    {
        c[idx] = a[idx] + b[idx];
    }
}

int main()
{
    const int N = 1000; // Array size
    const int blockSize = 256;
    const int numBlocks = (N + blockSize - 1) / blockSize;

    // Allocate memory on the host (CPU)
    float *h_a = new float[N];
    float *h_b = new float[N];
    float *h_c = new float[N];

    // Initialize input arrays on the host
    for (int i = 0; i < N; i++)
    {
        h_a[i] = i;
        h_b[i] = 2 * i;
    }

    // Allocate memory on the device (GPU)
    float *d_a, *d_b, *d_c;
    cudaMalloc((void **)&d_a, N * sizeof(float));
    cudaMalloc((void **)&d_b, N * sizeof(float));
    cudaMalloc((void **)&d_c, N * sizeof(float));

    // Copy input arrays from host to device
    cudaMemcpy(d_a, h_a, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, N * sizeof(float), cudaMemcpyHostToDevice);

    // Launch CUDA kernel to add arrays
    addArrays<<<numBlocks, blockSize>>>(d_a, d_b, d_c, N);

    // Wait for the GPU to finish
    cudaDeviceSynchronize();

    // Copy result array from device to host
    cudaMemcpy(h_c, d_c, N * sizeof(float), cudaMemcpyDeviceToHost);

    // Print result array
    std::cout << "Resultant array:" << std::endl;
    for (int i = 0; i < N; i++)
    {
        std::cout << h_c[i] << " ";
    }
    std::cout << std::endl;

    // Free allocated memory on the device
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    // Free allocated memory on the host
    delete[] h_a;
    delete[] h_b;
    delete[] h_c;

    return 0;
}

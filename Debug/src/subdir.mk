################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../src/Torsion.cu \
../src/kernel_torsion.cu 

CPP_SRCS += \
../src/DBOper.cpp \
../src/Diccionario.cpp \
../src/main.cpp 

OBJS += \
./src/DBOper.o \
./src/Diccionario.o \
./src/Torsion.o \
./src/kernel_torsion.o \
./src/main.o 

CU_DEPS += \
./src/Torsion.d \
./src/kernel_torsion.d 

CPP_DEPS += \
./src/DBOper.d \
./src/Diccionario.d \
./src/main.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/opt/cuda/bin/nvcc -G -g -O0 -v -Xcompiler -fPIC -gencode arch=compute_52,code=sm_52  -odir "src" -M -o "$(@:%.o=%.d)" "$<"
	/opt/cuda/bin/nvcc -G -g -O0 -v -Xcompiler -fPIC --compile  -x c++ -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/opt/cuda/bin/nvcc -G -g -O0 -v -Xcompiler -fPIC -gencode arch=compute_52,code=sm_52  -odir "src" -M -o "$(@:%.o=%.d)" "$<"
	/opt/cuda/bin/nvcc -G -g -O0 -v -Xcompiler -fPIC --compile --relocatable-device-code=true -gencode arch=compute_52,code=compute_52 -gencode arch=compute_52,code=sm_52  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '



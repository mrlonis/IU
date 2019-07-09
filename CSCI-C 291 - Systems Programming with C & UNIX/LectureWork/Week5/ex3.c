#include<stdio.h>

struct ComplexNumber {
  double real;
  double imaginary;
};

struct Parameters {
  struct ComplexNumber complex;
  double value;
};

struct Parameters param;
param.complex.real = 4.3;

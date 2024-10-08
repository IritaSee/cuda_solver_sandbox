#include <iostream>
#include <cusolverDn.h>
#include <cublas_v2.h>
#include <cuda_runtime.h>
#include <vector>

double *ALGEBRAIC;
double *CONSTANTS;
double *RATES;
double *STATES;

__global__ void initConsts(double* CONSTANTS, double* RATES, double *STATES)
{
STATES[0] = -86.2;
CONSTANTS[0] = 8.314;
CONSTANTS[1] = 310;
CONSTANTS[2] = 96.485;
CONSTANTS[3] = 185;
CONSTANTS[4] = 16404;
CONSTANTS[5] = 10;
CONSTANTS[6] = 1000;
CONSTANTS[7] = 1;
CONSTANTS[8] = -52;
CONSTANTS[9] = 0.03;
CONSTANTS[10] = 5.4;
CONSTANTS[11] = 140;
STATES[1] = 138.3;
STATES[2] = 11.6;
CONSTANTS[12] = 2;
STATES[3] = 0.0002;
CONSTANTS[13] = 5.405;
CONSTANTS[14] = 0.096;
STATES[4] = 0;
STATES[5] = 1;
CONSTANTS[15] = 0.062;
STATES[6] = 0;
CONSTANTS[16] = 14.838;
STATES[7] = 0;
STATES[8] = 0.75;
STATES[9] = 0.75;
CONSTANTS[17] = 0.00029;
CONSTANTS[18] = 0.175;
STATES[10] = 0;
STATES[11] = 1;
STATES[12] = 1;
CONSTANTS[19] = 0.000592;
CONSTANTS[20] = 0.294;
STATES[13] = 1;
STATES[14] = 0;
CONSTANTS[21] = 1.362;
CONSTANTS[22] = 1;
CONSTANTS[23] = 40;
CONSTANTS[24] = 1000;
CONSTANTS[25] = 0.1;
CONSTANTS[26] = 2.5;
CONSTANTS[27] = 0.35;
CONSTANTS[28] = 1.38;
CONSTANTS[29] = 87.5;
CONSTANTS[30] = 0.825;
CONSTANTS[31] = 0.0005;
CONSTANTS[32] = 0.0146;
STATES[15] = 0.2;
STATES[16] = 1;
CONSTANTS[33] = 2;
CONSTANTS[34] = 0.016464;
CONSTANTS[35] = 0.25;
CONSTANTS[36] = 0.008232;
CONSTANTS[37] = 0.00025;
CONSTANTS[38] = 8e-5;
CONSTANTS[39] = 0.000425;
CONSTANTS[40] = 0.15;
CONSTANTS[41] = 0.001;
CONSTANTS[42] = 10;
CONSTANTS[43] = 0.3;
CONSTANTS[44] = 1094;
CONSTANTS[45] = 2.00000;
}

__device__ void computeRates(double VOI, double* CONSTANTS, double* RATES, double* STATES, double* ALGEBRAIC)
{
ALGEBRAIC[8] = 1.00000/(1.00000+exp((STATES[0]+20.0000)/7.00000));
ALGEBRAIC[21] =  1125.00*exp(- pow(STATES[0]+27.0000, 2.00000)/240.000)+80.0000+165.000/(1.00000+exp((25.0000 - STATES[0])/10.0000));
RATES[11] = (ALGEBRAIC[8] - STATES[11])/ALGEBRAIC[21];
ALGEBRAIC[10] = 1.00000/(1.00000+exp((STATES[0]+20.0000)/5.00000));
ALGEBRAIC[23] =  85.0000*exp(- pow(STATES[0]+45.0000, 2.00000)/320.000)+5.00000/(1.00000+exp((STATES[0] - 20.0000)/5.00000))+3.00000;
RATES[13] = (ALGEBRAIC[10] - STATES[13])/ALGEBRAIC[23];
ALGEBRAIC[11] = 1.00000/(1.00000+exp((20.0000 - STATES[0])/6.00000));
ALGEBRAIC[24] =  9.50000*exp(- pow(STATES[0]+40.0000, 2.00000)/1800.00)+0.800000;
RATES[14] = (ALGEBRAIC[11] - STATES[14])/ALGEBRAIC[24];
ALGEBRAIC[12] = (STATES[3]<0.000350000 ? 1.00000/(1.00000+pow(STATES[3]/0.000350000, 6.00000)) : 1.00000/(1.00000+pow(STATES[3]/0.000350000, 16.0000)));
ALGEBRAIC[25] = (ALGEBRAIC[12] - STATES[16])/CONSTANTS[33];
RATES[16] = (ALGEBRAIC[12]>STATES[16]&&STATES[0]>- 60.0000 ? 0.00000 : ALGEBRAIC[25]);
ALGEBRAIC[1] = 1.00000/(1.00000+exp((- 26.0000 - STATES[0])/7.00000));
ALGEBRAIC[14] = 450.000/(1.00000+exp((- 45.0000 - STATES[0])/10.0000));
ALGEBRAIC[27] = 6.00000/(1.00000+exp((STATES[0]+30.0000)/11.5000));
ALGEBRAIC[36] =  1.00000*ALGEBRAIC[14]*ALGEBRAIC[27];
RATES[4] = (ALGEBRAIC[1] - STATES[4])/ALGEBRAIC[36];
ALGEBRAIC[2] = 1.00000/(1.00000+exp((STATES[0]+88.0000)/24.0000));
ALGEBRAIC[15] = 3.00000/(1.00000+exp((- 60.0000 - STATES[0])/20.0000));
ALGEBRAIC[28] = 1.12000/(1.00000+exp((STATES[0] - 60.0000)/20.0000));
ALGEBRAIC[37] =  1.00000*ALGEBRAIC[15]*ALGEBRAIC[28];
RATES[5] = (ALGEBRAIC[2] - STATES[5])/ALGEBRAIC[37];
ALGEBRAIC[3] = 1.00000/(1.00000+exp((- 5.00000 - STATES[0])/14.0000));
ALGEBRAIC[16] = 1100.00/ pow((1.00000+exp((- 10.0000 - STATES[0])/6.00000)), 1.0 / 2);
ALGEBRAIC[29] = 1.00000/(1.00000+exp((STATES[0] - 60.0000)/20.0000));
ALGEBRAIC[38] =  1.00000*ALGEBRAIC[16]*ALGEBRAIC[29];
RATES[6] = (ALGEBRAIC[3] - STATES[6])/ALGEBRAIC[38];
ALGEBRAIC[4] = 1.00000/pow(1.00000+exp((- 56.8600 - STATES[0])/9.03000), 2.00000);
ALGEBRAIC[17] = 1.00000/(1.00000+exp((- 60.0000 - STATES[0])/5.00000));
ALGEBRAIC[30] = 0.100000/(1.00000+exp((STATES[0]+35.0000)/5.00000))+0.100000/(1.00000+exp((STATES[0] - 50.0000)/200.000));
ALGEBRAIC[39] =  1.00000*ALGEBRAIC[17]*ALGEBRAIC[30];
RATES[7] = (ALGEBRAIC[4] - STATES[7])/ALGEBRAIC[39];
ALGEBRAIC[5] = 1.00000/pow(1.00000+exp((STATES[0]+71.5500)/7.43000), 2.00000);
ALGEBRAIC[18] = (STATES[0]<- 40.0000 ?  0.0570000*exp(- (STATES[0]+80.0000)/6.80000) : 0.00000);
ALGEBRAIC[31] = (STATES[0]<- 40.0000 ?  2.70000*exp( 0.0790000*STATES[0])+ 310000.*exp( 0.348500*STATES[0]) : 0.770000/( 0.130000*(1.00000+exp((STATES[0]+10.6600)/- 11.1000))));
ALGEBRAIC[40] = 1.00000/(ALGEBRAIC[18]+ALGEBRAIC[31]);
RATES[8] = (ALGEBRAIC[5] - STATES[8])/ALGEBRAIC[40];
ALGEBRAIC[6] = 1.00000/pow(1.00000+exp((STATES[0]+71.5500)/7.43000), 2.00000);
ALGEBRAIC[19] = (STATES[0]<- 40.0000 ? (( ( - 25428.0*exp( 0.244400*STATES[0]) -  6.94800e-06*exp( - 0.0439100*STATES[0]))*(STATES[0]+37.7800))/1.00000)/(1.00000+exp( 0.311000*(STATES[0]+79.2300))) : 0.00000);
ALGEBRAIC[32] = (STATES[0]<- 40.0000 ? ( 0.0242400*exp( - 0.0105200*STATES[0]))/(1.00000+exp( - 0.137800*(STATES[0]+40.1400))) : ( 0.600000*exp( 0.0570000*STATES[0]))/(1.00000+exp( - 0.100000*(STATES[0]+32.0000))));
ALGEBRAIC[41] = 1.00000/(ALGEBRAIC[19]+ALGEBRAIC[32]);
RATES[9] = (ALGEBRAIC[6] - STATES[9])/ALGEBRAIC[41];
ALGEBRAIC[7] = 1.00000/(1.00000+exp((- 5.00000 - STATES[0])/7.50000));
ALGEBRAIC[20] = 1.40000/(1.00000+exp((- 35.0000 - STATES[0])/13.0000))+0.250000;
ALGEBRAIC[33] = 1.40000/(1.00000+exp((STATES[0]+5.00000)/5.00000));
ALGEBRAIC[42] = 1.00000/(1.00000+exp((50.0000 - STATES[0])/20.0000));
ALGEBRAIC[45] =  1.00000*ALGEBRAIC[20]*ALGEBRAIC[33]+ALGEBRAIC[42];
RATES[10] = (ALGEBRAIC[7] - STATES[10])/ALGEBRAIC[45];
ALGEBRAIC[9] = 1.00000/(1.00000+pow(STATES[3]/0.000325000, 8.00000));
ALGEBRAIC[22] = 0.100000/(1.00000+exp((STATES[3] - 0.000500000)/0.000100000));
ALGEBRAIC[34] = 0.200000/(1.00000+exp((STATES[3] - 0.000750000)/0.000800000));
ALGEBRAIC[43] = (ALGEBRAIC[9]+ALGEBRAIC[22]+ALGEBRAIC[34]+0.230000)/1.46000;
ALGEBRAIC[46] = (ALGEBRAIC[43] - STATES[12])/CONSTANTS[45];
RATES[12] = (ALGEBRAIC[43]>STATES[12]&&STATES[0]>- 60.0000 ? 0.00000 : ALGEBRAIC[46]);
ALGEBRAIC[58] = (( (( CONSTANTS[21]*CONSTANTS[10])/(CONSTANTS[10]+CONSTANTS[22]))*STATES[2])/(STATES[2]+CONSTANTS[23]))/(1.00000+ 0.124500*exp(( - 0.100000*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))+ 0.0353000*exp(( - STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1])));
ALGEBRAIC[13] =  (( CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log(CONSTANTS[11]/STATES[2]);
ALGEBRAIC[53] =  CONSTANTS[16]*pow(STATES[7], 3.00000)*STATES[8]*STATES[9]*(STATES[0] - ALGEBRAIC[13]);
ALGEBRAIC[54] =  CONSTANTS[17]*(STATES[0] - ALGEBRAIC[13]);
ALGEBRAIC[59] = ( CONSTANTS[24]*( exp(( CONSTANTS[27]*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))*pow(STATES[2], 3.00000)*CONSTANTS[12] -  exp(( (CONSTANTS[27] - 1.00000)*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))*pow(CONSTANTS[11], 3.00000)*STATES[3]*CONSTANTS[26]))/( (pow(CONSTANTS[29], 3.00000)+pow(CONSTANTS[11], 3.00000))*(CONSTANTS[28]+CONSTANTS[12])*(1.00000+ CONSTANTS[25]*exp(( (CONSTANTS[27] - 1.00000)*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))));
RATES[2] = ( - (ALGEBRAIC[53]+ALGEBRAIC[54]+ 3.00000*ALGEBRAIC[58]+ 3.00000*ALGEBRAIC[59])*CONSTANTS[3])/( CONSTANTS[4]*CONSTANTS[2]);
ALGEBRAIC[26] =  (( CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log(CONSTANTS[10]/STATES[1]);
ALGEBRAIC[47] = 0.100000/(1.00000+exp( 0.0600000*((STATES[0] - ALGEBRAIC[26]) - 200.000)));
ALGEBRAIC[48] = ( 3.00000*exp( 0.000200000*((STATES[0] - ALGEBRAIC[26])+100.000))+ 1.00000*exp( 0.100000*((STATES[0] - ALGEBRAIC[26]) - 10.0000)))/(1.00000+exp( - 0.500000*(STATES[0] - ALGEBRAIC[26])));
ALGEBRAIC[49] = ALGEBRAIC[47]/(ALGEBRAIC[47]+ALGEBRAIC[48]);
ALGEBRAIC[50] =  CONSTANTS[13]*ALGEBRAIC[49]* pow((CONSTANTS[10]/5.40000), 1.0 / 2)*(STATES[0] - ALGEBRAIC[26]);
ALGEBRAIC[57] =  CONSTANTS[20]*STATES[14]*STATES[13]*(STATES[0] - ALGEBRAIC[26]);
ALGEBRAIC[51] =  CONSTANTS[14]* pow((CONSTANTS[10]/5.40000), 1.0 / 2)*STATES[4]*STATES[5]*(STATES[0] - ALGEBRAIC[26]);
ALGEBRAIC[35] =  (( CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log((CONSTANTS[10]+ CONSTANTS[9]*CONSTANTS[11])/(STATES[1]+ CONSTANTS[9]*STATES[2]));
ALGEBRAIC[52] =  CONSTANTS[15]*pow(STATES[6], 2.00000)*(STATES[0] - ALGEBRAIC[35]);
ALGEBRAIC[55] = ( (( CONSTANTS[18]*STATES[10]*STATES[11]*STATES[12]*4.00000*STATES[0]*pow(CONSTANTS[2], 2.00000))/( CONSTANTS[0]*CONSTANTS[1]))*( STATES[3]*exp(( 2.00000*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1])) -  0.341000*CONSTANTS[12]))/(exp(( 2.00000*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1])) - 1.00000);
ALGEBRAIC[44] =  (( 0.500000*CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log(CONSTANTS[12]/STATES[3]);
ALGEBRAIC[56] =  CONSTANTS[19]*(STATES[0] - ALGEBRAIC[44]);
ALGEBRAIC[61] = ( CONSTANTS[32]*(STATES[0] - ALGEBRAIC[26]))/(1.00000+exp((25.0000 - STATES[0])/5.98000));
ALGEBRAIC[60] = ( CONSTANTS[30]*STATES[3])/(STATES[3]+CONSTANTS[31]);
ALGEBRAIC[0] = (VOI -  floor(VOI/CONSTANTS[6])*CONSTANTS[6]>=CONSTANTS[5]&&VOI -  floor(VOI/CONSTANTS[6])*CONSTANTS[6]<=CONSTANTS[5]+CONSTANTS[7] ? CONSTANTS[8] : 0.00000);
RATES[0] = - (ALGEBRAIC[50]+ALGEBRAIC[57]+ALGEBRAIC[51]+ALGEBRAIC[52]+ALGEBRAIC[55]+ALGEBRAIC[58]+ALGEBRAIC[53]+ALGEBRAIC[54]+ALGEBRAIC[59]+ALGEBRAIC[56]+ALGEBRAIC[61]+ALGEBRAIC[60]+ALGEBRAIC[0]);
RATES[1] = ( - ((ALGEBRAIC[50]+ALGEBRAIC[57]+ALGEBRAIC[51]+ALGEBRAIC[52]+ALGEBRAIC[61]+ALGEBRAIC[0]) -  2.00000*ALGEBRAIC[58])*CONSTANTS[3])/( CONSTANTS[4]*CONSTANTS[2]);
ALGEBRAIC[62] =  (( CONSTANTS[34]*pow(STATES[15], 2.00000))/(pow(CONSTANTS[35], 2.00000)+pow(STATES[15], 2.00000))+CONSTANTS[36])*STATES[10]*STATES[16];
ALGEBRAIC[63] = CONSTANTS[39]/(1.00000+pow(CONSTANTS[37], 2.00000)/pow(STATES[3], 2.00000));
ALGEBRAIC[64] =  CONSTANTS[38]*(STATES[15] - STATES[3]);
ALGEBRAIC[65] = (( (- ((ALGEBRAIC[55]+ALGEBRAIC[56]+ALGEBRAIC[60]) -  2.00000*ALGEBRAIC[59])/( 2.00000*CONSTANTS[4]*CONSTANTS[2]))*CONSTANTS[3]+ALGEBRAIC[64]) - ALGEBRAIC[63])+ALGEBRAIC[62];
ALGEBRAIC[67] = 1.00000/(1.00000+( CONSTANTS[40]*CONSTANTS[41])/pow(STATES[3]+CONSTANTS[41], 2.00000));
RATES[3] =  ALGEBRAIC[65]*ALGEBRAIC[67];
ALGEBRAIC[66] =  (CONSTANTS[4]/CONSTANTS[44])*(ALGEBRAIC[63] - (ALGEBRAIC[62]+ALGEBRAIC[64]));
ALGEBRAIC[68] = 1.00000/(1.00000+( CONSTANTS[42]*CONSTANTS[43])/pow(STATES[15]+CONSTANTS[43], 2.00000));
RATES[15] =  ALGEBRAIC[66]*ALGEBRAIC[68];
}

__device__ void computeVariables(double VOI, double* CONSTANTS, double* RATES, double* STATES, double* ALGEBRAIC)
{
ALGEBRAIC[8] = 1.00000/(1.00000+exp((STATES[0]+20.0000)/7.00000));
ALGEBRAIC[21] =  1125.00*exp(- pow(STATES[0]+27.0000, 2.00000)/240.000)+80.0000+165.000/(1.00000+exp((25.0000 - STATES[0])/10.0000));
ALGEBRAIC[10] = 1.00000/(1.00000+exp((STATES[0]+20.0000)/5.00000));
ALGEBRAIC[23] =  85.0000*exp(- pow(STATES[0]+45.0000, 2.00000)/320.000)+5.00000/(1.00000+exp((STATES[0] - 20.0000)/5.00000))+3.00000;
ALGEBRAIC[11] = 1.00000/(1.00000+exp((20.0000 - STATES[0])/6.00000));
ALGEBRAIC[24] =  9.50000*exp(- pow(STATES[0]+40.0000, 2.00000)/1800.00)+0.800000;
ALGEBRAIC[12] = (STATES[3]<0.000350000 ? 1.00000/(1.00000+pow(STATES[3]/0.000350000, 6.00000)) : 1.00000/(1.00000+pow(STATES[3]/0.000350000, 16.0000)));
ALGEBRAIC[25] = (ALGEBRAIC[12] - STATES[16])/CONSTANTS[33];
ALGEBRAIC[1] = 1.00000/(1.00000+exp((- 26.0000 - STATES[0])/7.00000));
ALGEBRAIC[14] = 450.000/(1.00000+exp((- 45.0000 - STATES[0])/10.0000));
ALGEBRAIC[27] = 6.00000/(1.00000+exp((STATES[0]+30.0000)/11.5000));
ALGEBRAIC[36] =  1.00000*ALGEBRAIC[14]*ALGEBRAIC[27];
ALGEBRAIC[2] = 1.00000/(1.00000+exp((STATES[0]+88.0000)/24.0000));
ALGEBRAIC[15] = 3.00000/(1.00000+exp((- 60.0000 - STATES[0])/20.0000));
ALGEBRAIC[28] = 1.12000/(1.00000+exp((STATES[0] - 60.0000)/20.0000));
ALGEBRAIC[37] =  1.00000*ALGEBRAIC[15]*ALGEBRAIC[28];
ALGEBRAIC[3] = 1.00000/(1.00000+exp((- 5.00000 - STATES[0])/14.0000));
ALGEBRAIC[16] = 1100.00/ pow((1.00000+exp((- 10.0000 - STATES[0])/6.00000)), 1.0 / 2);
ALGEBRAIC[29] = 1.00000/(1.00000+exp((STATES[0] - 60.0000)/20.0000));
ALGEBRAIC[38] =  1.00000*ALGEBRAIC[16]*ALGEBRAIC[29];
ALGEBRAIC[4] = 1.00000/pow(1.00000+exp((- 56.8600 - STATES[0])/9.03000), 2.00000);
ALGEBRAIC[17] = 1.00000/(1.00000+exp((- 60.0000 - STATES[0])/5.00000));
ALGEBRAIC[30] = 0.100000/(1.00000+exp((STATES[0]+35.0000)/5.00000))+0.100000/(1.00000+exp((STATES[0] - 50.0000)/200.000));
ALGEBRAIC[39] =  1.00000*ALGEBRAIC[17]*ALGEBRAIC[30];
ALGEBRAIC[5] = 1.00000/pow(1.00000+exp((STATES[0]+71.5500)/7.43000), 2.00000);
ALGEBRAIC[18] = (STATES[0]<- 40.0000 ?  0.0570000*exp(- (STATES[0]+80.0000)/6.80000) : 0.00000);
ALGEBRAIC[31] = (STATES[0]<- 40.0000 ?  2.70000*exp( 0.0790000*STATES[0])+ 310000.*exp( 0.348500*STATES[0]) : 0.770000/( 0.130000*(1.00000+exp((STATES[0]+10.6600)/- 11.1000))));
ALGEBRAIC[40] = 1.00000/(ALGEBRAIC[18]+ALGEBRAIC[31]);
ALGEBRAIC[6] = 1.00000/pow(1.00000+exp((STATES[0]+71.5500)/7.43000), 2.00000);
ALGEBRAIC[19] = (STATES[0]<- 40.0000 ? (( ( - 25428.0*exp( 0.244400*STATES[0]) -  6.94800e-06*exp( - 0.0439100*STATES[0]))*(STATES[0]+37.7800))/1.00000)/(1.00000+exp( 0.311000*(STATES[0]+79.2300))) : 0.00000);
ALGEBRAIC[32] = (STATES[0]<- 40.0000 ? ( 0.0242400*exp( - 0.0105200*STATES[0]))/(1.00000+exp( - 0.137800*(STATES[0]+40.1400))) : ( 0.600000*exp( 0.0570000*STATES[0]))/(1.00000+exp( - 0.100000*(STATES[0]+32.0000))));
ALGEBRAIC[41] = 1.00000/(ALGEBRAIC[19]+ALGEBRAIC[32]);
ALGEBRAIC[7] = 1.00000/(1.00000+exp((- 5.00000 - STATES[0])/7.50000));
ALGEBRAIC[20] = 1.40000/(1.00000+exp((- 35.0000 - STATES[0])/13.0000))+0.250000;
ALGEBRAIC[33] = 1.40000/(1.00000+exp((STATES[0]+5.00000)/5.00000));
ALGEBRAIC[42] = 1.00000/(1.00000+exp((50.0000 - STATES[0])/20.0000));
ALGEBRAIC[45] =  1.00000*ALGEBRAIC[20]*ALGEBRAIC[33]+ALGEBRAIC[42];
ALGEBRAIC[9] = 1.00000/(1.00000+pow(STATES[3]/0.000325000, 8.00000));
ALGEBRAIC[22] = 0.100000/(1.00000+exp((STATES[3] - 0.000500000)/0.000100000));
ALGEBRAIC[34] = 0.200000/(1.00000+exp((STATES[3] - 0.000750000)/0.000800000));
ALGEBRAIC[43] = (ALGEBRAIC[9]+ALGEBRAIC[22]+ALGEBRAIC[34]+0.230000)/1.46000;
ALGEBRAIC[46] = (ALGEBRAIC[43] - STATES[12])/CONSTANTS[45];
ALGEBRAIC[58] = (( (( CONSTANTS[21]*CONSTANTS[10])/(CONSTANTS[10]+CONSTANTS[22]))*STATES[2])/(STATES[2]+CONSTANTS[23]))/(1.00000+ 0.124500*exp(( - 0.100000*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))+ 0.0353000*exp(( - STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1])));
ALGEBRAIC[13] =  (( CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log(CONSTANTS[11]/STATES[2]);
ALGEBRAIC[53] =  CONSTANTS[16]*pow(STATES[7], 3.00000)*STATES[8]*STATES[9]*(STATES[0] - ALGEBRAIC[13]);
ALGEBRAIC[54] =  CONSTANTS[17]*(STATES[0] - ALGEBRAIC[13]);
ALGEBRAIC[59] = ( CONSTANTS[24]*( exp(( CONSTANTS[27]*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))*pow(STATES[2], 3.00000)*CONSTANTS[12] -  exp(( (CONSTANTS[27] - 1.00000)*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))*pow(CONSTANTS[11], 3.00000)*STATES[3]*CONSTANTS[26]))/( (pow(CONSTANTS[29], 3.00000)+pow(CONSTANTS[11], 3.00000))*(CONSTANTS[28]+CONSTANTS[12])*(1.00000+ CONSTANTS[25]*exp(( (CONSTANTS[27] - 1.00000)*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1]))));
ALGEBRAIC[26] =  (( CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log(CONSTANTS[10]/STATES[1]);
ALGEBRAIC[47] = 0.100000/(1.00000+exp( 0.0600000*((STATES[0] - ALGEBRAIC[26]) - 200.000)));
ALGEBRAIC[48] = ( 3.00000*exp( 0.000200000*((STATES[0] - ALGEBRAIC[26])+100.000))+ 1.00000*exp( 0.100000*((STATES[0] - ALGEBRAIC[26]) - 10.0000)))/(1.00000+exp( - 0.500000*(STATES[0] - ALGEBRAIC[26])));
ALGEBRAIC[49] = ALGEBRAIC[47]/(ALGEBRAIC[47]+ALGEBRAIC[48]);
ALGEBRAIC[50] =  CONSTANTS[13]*ALGEBRAIC[49]* pow((CONSTANTS[10]/5.40000), 1.0 / 2)*(STATES[0] - ALGEBRAIC[26]);
ALGEBRAIC[57] =  CONSTANTS[20]*STATES[14]*STATES[13]*(STATES[0] - ALGEBRAIC[26]);
ALGEBRAIC[51] =  CONSTANTS[14]* pow((CONSTANTS[10]/5.40000), 1.0 / 2)*STATES[4]*STATES[5]*(STATES[0] - ALGEBRAIC[26]);
ALGEBRAIC[35] =  (( CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log((CONSTANTS[10]+ CONSTANTS[9]*CONSTANTS[11])/(STATES[1]+ CONSTANTS[9]*STATES[2]));
ALGEBRAIC[52] =  CONSTANTS[15]*pow(STATES[6], 2.00000)*(STATES[0] - ALGEBRAIC[35]);
ALGEBRAIC[55] = ( (( CONSTANTS[18]*STATES[10]*STATES[11]*STATES[12]*4.00000*STATES[0]*pow(CONSTANTS[2], 2.00000))/( CONSTANTS[0]*CONSTANTS[1]))*( STATES[3]*exp(( 2.00000*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1])) -  0.341000*CONSTANTS[12]))/(exp(( 2.00000*STATES[0]*CONSTANTS[2])/( CONSTANTS[0]*CONSTANTS[1])) - 1.00000);
ALGEBRAIC[44] =  (( 0.500000*CONSTANTS[0]*CONSTANTS[1])/CONSTANTS[2])*log(CONSTANTS[12]/STATES[3]);
ALGEBRAIC[56] =  CONSTANTS[19]*(STATES[0] - ALGEBRAIC[44]);
ALGEBRAIC[61] = ( CONSTANTS[32]*(STATES[0] - ALGEBRAIC[26]))/(1.00000+exp((25.0000 - STATES[0])/5.98000));
ALGEBRAIC[60] = ( CONSTANTS[30]*STATES[3])/(STATES[3]+CONSTANTS[31]);
ALGEBRAIC[0] = (VOI -  floor(VOI/CONSTANTS[6])*CONSTANTS[6]>=CONSTANTS[5]&&VOI -  floor(VOI/CONSTANTS[6])*CONSTANTS[6]<=CONSTANTS[5]+CONSTANTS[7] ? CONSTANTS[8] : 0.00000);
ALGEBRAIC[62] =  (( CONSTANTS[34]*pow(STATES[15], 2.00000))/(pow(CONSTANTS[35], 2.00000)+pow(STATES[15], 2.00000))+CONSTANTS[36])*STATES[10]*STATES[16];
ALGEBRAIC[63] = CONSTANTS[39]/(1.00000+pow(CONSTANTS[37], 2.00000)/pow(STATES[3], 2.00000));
ALGEBRAIC[64] =  CONSTANTS[38]*(STATES[15] - STATES[3]);
ALGEBRAIC[65] = (( (- ((ALGEBRAIC[55]+ALGEBRAIC[56]+ALGEBRAIC[60]) -  2.00000*ALGEBRAIC[59])/( 2.00000*CONSTANTS[4]*CONSTANTS[2]))*CONSTANTS[3]+ALGEBRAIC[64]) - ALGEBRAIC[63])+ALGEBRAIC[62];
ALGEBRAIC[67] = 1.00000/(1.00000+( CONSTANTS[40]*CONSTANTS[41])/pow(STATES[3]+CONSTANTS[41], 2.00000));
ALGEBRAIC[66] =  (CONSTANTS[4]/CONSTANTS[44])*(ALGEBRAIC[63] - (ALGEBRAIC[62]+ALGEBRAIC[64]));
ALGEBRAIC[68] = 1.00000/(1.00000+( CONSTANTS[42]*CONSTANTS[43])/pow(STATES[15]+CONSTANTS[43], 2.00000));
}

// Define the function f(t, y) for the system of ODEs dy/dt = f(t, y)
// __global__ void ODEFunction(double *y, double *dy, double t, int n) {
//     // ODE system: dy/dt = A * y, where A is a diagonal matrix with different coefficients
//     for (int i = 0; i < n; ++i) {
//         switch (i) {
//             case 0: dy[i] = -2.0 * y[i]; break;   // dy1/dt = -2 * y1
//             case 1: dy[i] = -1.0 * y[i]; break;   // dy2/dt = -y2
//             case 2: dy[i] = -0.5 * y[i]; break;   // dy3/dt = -0.5 * y3
//             case 3: dy[i] = -0.25 * y[i]; break;  // dy4/dt = -0.25 * y4
//             case 4: dy[i] = -0.1 * y[i]; break;   // dy5/dt = -0.1 * y5
//         }
//     }
// }

__global__ void bridgeFunction(double t, double* STATES, double* RATES, double* CONSTANTS, double* ALGEBRAIC){
    
    computeRates(t, CONSTANTS, RATES, STATES, ALGEBRAIC);

    computeVariables(t, CONSTANTS, RATES, STATES, ALGEBRAIC);

}


// Solve the system of ODEs using BDF
void solveODEBDF(double t0, double t1, double* STATES, double* RATES, double* CONSTANTS, double* ALGEBRAIC, int n, int steps, bool init) {
    cublasHandle_t cublasHandle;
    cublasCreate(&cublasHandle);

    int num_of_constants = 45;
    int num_of_states = 17;
    int num_of_algebraic = 69;
    int num_of_rates = 17;

    double dt = (t1 - t0) / steps;
    double t = t0;

    // Allocate memory for y and dy
    double *d_ALGEBRAIC;
    double *d_CONSTANTS;
    double *d_RATES;
    double *d_STATES;

    cudaMalloc(&d_ALGEBRAIC, num_of_algebraic * sizeof(double));
    cudaMalloc(&d_CONSTANTS, num_of_constants * sizeof(double));
    cudaMalloc(&d_RATES, num_of_rates * sizeof(double));
    cudaMalloc(&d_STATES, num_of_states * sizeof(double));

    // Initialize y with initial conditions
    // cudaMemcpy(d_y, y0, n * sizeof(double), cudaMemcpyHostToDevice);
    if (init == true){
    initConsts<<<1,n>>>(CONSTANTS, RATES, STATES);
    cudaDeviceSynchronize();
    // init == true;
    }
    
    for (int i = 0; i < steps; ++i) {
        // Compute dy = f(t, y)
        // ODEFunction<<<1, n>>>(d_y, d_dy, t, n);
        bridgeFunction<<<1,n>>>(t, STATES, RATES, CONSTANTS, ALGEBRAIC);
        cudaDeviceSynchronize();

        // Solve the linear system (I - dt * J) * y_new = y_old
        // For this example, we assume J is identity and dy is small, so BDF simplifies to:
        // y_new = y_old + dt * f(t, y)

        double alpha = dt;
        cublasDaxpy(cublasHandle, n, &alpha, RATES, 1, STATES, 1); // y_new = y_old + dt * dy

        // Update time
        t += dt;
    }

    // Copy the result back to host
    cudaMemcpy(STATES, d_STATES, n * sizeof(double), cudaMemcpyDeviceToHost);
    

    // Clean up
    cudaFree(d_ALGEBRAIC);
    cudaFree(d_CONSTANTS);
    cudaFree(d_STATES);
    cudaFree(d_RATES);

    cublasDestroy(cublasHandle);
}



int main() {
    double t0 = 0.0;
    double t1 = 1.0;
    int n = 17;  // Number of ODEs
    int steps = 10;
    bool init = true;

    int num_of_constants = 45;
    int num_of_states = 17;
    int num_of_algebraic = 69;
    int num_of_rates = 17;

    STATES = (double *)malloc(num_of_states  * sizeof(double));
    RATES = (double *)malloc(num_of_rates  * sizeof(double));
    ALGEBRAIC = (double *)malloc(num_of_algebraic  * sizeof(double));
    CONSTANTS = (double *)malloc(num_of_constants  * sizeof(double));

    // Initial conditions for the 5 ODEs
    // std::vector<double> y0 = {1.0, 1.0, 1.0, 1.0, 1.0};
    for(int loop=0; loop < 100; loop++){
        solveODEBDF(t0, t1, STATES, RATES, CONSTANTS, ALGEBRAIC, n, steps, init);
        init = false;
        for (int i = 0; i < n; ++i) {
        std::cout << "rates " << i << " = " << RATES[i] << std::endl;
    }
        printf("\n");
        t0 = t1;
        t1 = t1+0.5;
    }
    

    // Output the solutions at t = t1
    // std::cout << "Solutions at t = " << t1 << " are:" << std::endl;
    // for (int i = 0; i < n; ++i) {
    //     std::cout << "y" << i + 1 << " = " << y0[i] << std::endl;
    // }

    return 0;
}

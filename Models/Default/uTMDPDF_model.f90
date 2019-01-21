!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!			Model for unpolarized TMD PDF
!
!			corresponds to model 1
!			FNP=Cosh((l1/l2-l1/2)b)/Cosh((l1/l2+l1/2)b)
!			muOPE=C0/b+2
!
!			Model for unpolarized TMD evolution for BSV19_EXP
!
!			corresponds to bb* model
!
!			Requres six NP parameters (initated by best values values)
!			Uses NNPDF31_nnlo_as_0118 PDF set (replica 0)
!				A.Vladimirov (27.12.2018)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USER DEFINED FUNCTIONS   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  !!!!!! Write nessecery model intitialization.
  subroutine ModelInitialization()  
    name="BSV19_EXP"
    
    write(*,*) 'Model BSV19_EXP is used. Please, cite ????.????'
    
  end subroutine ModelInitialization
  
  
  !!! This is  non-pertrubative function
  !!! non=pertrubative parameters are lambdaNP()
  !!! x-- is the bjorken variable of TMD
  !!! z-- is convolution variable
  function FNP(x,z,bT,hadron,lambdaNP)
  real*8::x,z,bT
  real*8,dimension(-5:5)::FNP
  real*8::FNP0
  integer::hadron
  real*8,intent(in)::lambdaNP(:)

   real*8::bb,w1,w2,w3
   bb=bT**2
   w1=lambdaNP(1)*(1-x)+x*lambdaNP(2)+x*(1-x)*lambdaNP(5)
   w2=lambdaNP(3)*x**lambdaNP(4)+lambdaNP(6)
   
   if(w2<0d0 .or. w1<0d0) then
   FNP0=-1d0
   else
   FNP0=Exp(-w1*bb/sqrt(1+w2*bb))
   end if

  FNP=FNP0*(/1d0,1d0,1d0,1d0,1d0,1d0,1d0,1d0,1d0,1d0,1d0/)
  end function FNP
  
    !!!!This function is the mu(x,b), which is used inside the OPE
  function mu_OPE(x,bt)
  real*8::bt,mu_OPE,x
  !mu_OPE=C0_const*SQRT(1+bT**2)/bT+1d0
  mu_OPE=C0_const*1d0/bT+2d0
  
  if(mu_OPE>1000d0) then
    mu_OPE=1000d0
  end if
  end function mu_OPE
  
   !!! this is the table of replica prameters extracted in fit BSV19.
 !!! -2 is suggested for initialization replica
 !!! -1 is the best fit
 !!! 0 is the mean reaplics
 !!! 1 -- 100 replicas
 function ReplicaParameters(rep)
 integer::rep
 real*8::ReplicaParameters(1:6)
 real,parameter,dimension(1:618)::replicas=(/&
    0.2437,   7.4953, 312.1787,   2.4385,  -4.4142,   0.1000,&
    0.2437,   7.4953, 312.1787,   2.4385,  -4.4142,   0.0000,&
    0.2568,   7.9197, 293.5190,   2.4320,  -4.4834,   0.0000,&
    0.2564,   7.7306, 328.0816,   2.4779,  -4.0789,   0.0000,&
    0.2793,   6.7401, 223.4298,   2.5801,  -4.6892,   0.0000,&
    0.2373,   7.8683, 308.1561,   2.5792,  -4.2976,   0.0000,&
    0.2715,   6.9642, 185.0476,   2.3794,  -4.4816,   0.0000,&
    0.2554,   8.0370, 243.0865,   2.2021,  -4.1900,   0.0000,&
    0.2373,   8.0942, 270.6952,   2.4248,  -4.2093,   0.0000,&
    0.2502,   7.5396, 317.4076,   2.6366,  -4.8150,   0.0000,&
    0.2500,   7.9443, 289.1880,   2.3631,  -3.8987,   0.0000,&
    0.2730,   7.2182, 184.9702,   2.3539,  -4.4752,   0.0000,&
    0.2473,   7.9247, 221.5587,   2.2228,  -3.8102,   0.0000,&
    0.2481,   7.8006, 321.4615,   2.4877,  -3.9668,   0.0000,&
    0.2559,   7.8966, 316.8157,   2.4498,  -4.2547,   0.0000,&
    0.2667,   7.1880, 202.1673,   2.4505,  -4.8019,   0.0000,&
    0.2508,   7.3593, 209.8085,   2.1685,  -3.5385,   0.0000,&
    0.2559,   7.8418, 331.5211,   2.5356,  -4.2026,   0.0000,&
    0.2434,   7.7007, 258.0952,   2.3326,  -4.4998,   0.0000,&
    0.2549,   7.8525, 317.5596,   2.4903,  -4.3475,   0.0000,&
    0.2482,   7.6536, 319.3058,   2.4760,  -4.2071,   0.0000,&
    0.2661,   8.1863, 249.0015,   2.2616,  -4.0901,   0.0000,&
    0.2629,   8.5868, 290.0408,   2.3153,  -5.1873,   0.0000,&
    0.2548,   7.7088, 261.3679,   2.2825,  -4.1026,   0.0000,&
    0.2780,   8.1538, 357.8250,   2.5375,  -5.4031,   0.0000,&
    0.2550,   7.6498, 317.5928,   2.4626,  -4.3738,   0.0000,&
    0.2642,   7.8405, 317.7759,   2.4671,  -4.4647,   0.0000,&
    0.2489,   8.5717, 292.6091,   2.3753,  -4.0640,   0.0000,&
    0.2514,   7.7093, 312.6460,   2.4712,  -3.9747,   0.0000,&
    0.1899,   9.0278, 396.9096,   2.4093,  -4.0474,   0.0000,&
    0.2389,   7.6160, 310.7305,   2.3522,  -3.3593,   0.0000,&
    0.2515,   7.5523, 310.8768,   2.4375,  -4.4095,   0.0000,&
    0.2720,   8.6438, 269.8318,   2.4574,  -5.4887,   0.0000,&
    0.2524,   7.7554, 319.5045,   2.4772,  -4.2997,   0.0000,&
    0.2651,   7.9456, 280.3903,   2.3934,  -4.2734,   0.0000,&
    0.2518,   7.6846, 311.6707,   2.4743,  -4.2558,   0.0000,&
    0.2059,   9.0346, 361.8759,   2.2663,  -2.9613,   0.0000,&
    0.2689,   8.1761, 306.6347,   2.4295,  -4.1185,   0.0000,&
    0.2449,   7.7800, 311.9126,   2.4681,  -4.0512,   0.0000,&
    0.2474,   7.6331, 312.0701,   2.4502,  -4.5214,   0.0000,&
    0.2610,   7.6809, 312.6059,   2.4111,  -4.2557,   0.0000,&
    0.2527,   7.7017, 315.1713,   2.4483,  -4.2656,   0.0000,&
    0.2503,   7.9267, 225.9492,   2.3124,  -4.3557,   0.0000,&
    0.2837,   9.1973, 274.5970,   2.4371,  -5.8857,   0.0000,&
    0.2468,   7.5874, 314.5250,   2.4534,  -4.3807,   0.0000,&
    0.2490,   7.6678, 313.1267,   2.4047,  -4.3059,   0.0000,&
    0.2618,   7.9229, 331.7777,   2.4887,  -4.5574,   0.0000,&
    0.2480,   7.5016, 310.3107,   2.4225,  -4.4813,   0.0000,&
    0.2808,   8.1163, 336.1891,   2.5023,  -4.9833,   0.0000,&
    0.2456,   7.5531, 315.3246,   2.4665,  -4.3650,   0.0000,&
    0.2903,   6.4921, 218.2562,   2.6685,  -5.0424,   0.0000,&
    0.2788,   8.1023, 316.1928,   2.5256,  -5.1032,   0.0000,&
    0.2508,   7.6345, 318.2295,   2.4779,  -4.3771,   0.0000,&
    0.3076,   7.9782, 218.0450,   2.4483,  -6.0091,   0.0000,&
    0.2548,   7.7088, 261.3675,   2.2825,  -4.1026,   0.0000,&
    0.2354,   7.7073, 235.2948,   2.2715,  -4.2292,   0.0000,&
    0.2939,   8.6412, 215.4368,   2.3436,  -6.2265,   0.0000,&
    0.2487,   7.9763, 261.5116,   2.4419,  -5.1557,   0.0000,&
    0.2442,   7.5420, 317.2569,   2.4624,  -4.3426,   0.0000,&
    0.3107,   7.2757, 201.0119,   2.4409,  -4.7355,   0.0000,&
    0.2426,   7.7041, 265.1151,   2.4060,  -4.3267,   0.0000,&
    0.2433,   7.5677, 317.5246,   2.4681,  -4.1979,   0.0000,&
    0.2490,   7.6678, 313.1267,   2.4047,  -4.3059,   0.0000,&
    0.2484,   7.6610, 328.9904,   2.5022,  -4.2596,   0.0000,&
    0.2660,   8.0956, 317.4155,   2.4808,  -4.5448,   0.0000,&
    0.2176,  10.1616, 356.2343,   2.4547,  -5.7881,   0.0000,&
    0.2470,   7.7025, 321.0957,   2.4855,  -4.0520,   0.0000,&
    0.2508,   7.6009, 317.4093,   2.4585,  -4.2027,   0.0000,&
    0.2880,   8.7553, 411.7707,   2.7801,  -6.2939,   0.0000,&
    0.2529,   7.7948, 318.2202,   2.4761,  -4.2871,   0.0000,&
    0.2457,   7.6429, 305.1716,   2.3947,  -3.8322,   0.0000,&
    0.2468,   7.4759, 312.4756,   2.4278,  -4.2238,   0.0000,&
    0.2750,   8.0243, 200.1591,   2.2837,  -4.6144,   0.0000,&
    0.2943,  11.4569, 378.9999,   2.5333,  -8.6070,   0.0000,&
    0.2459,   7.6071, 314.4299,   2.4612,  -4.2700,   0.0000,&
    0.2731,   7.7713, 325.3031,   2.4850,  -4.0966,   0.0000,&
    0.2529,   7.6516, 315.3543,   2.4511,  -4.4052,   0.0000,&
    0.2517,   7.6933, 316.4380,   2.4695,  -4.2153,   0.0000,&
    0.2570,   7.7315, 320.9176,   2.4916,  -4.5591,   0.0000,&
    0.2423,   7.6259, 314.6124,   2.4827,  -4.2086,   0.0000,&
    0.2495,   7.7176, 318.6742,   2.4809,  -4.3342,   0.0000,&
    0.2541,   7.6837, 308.5243,   2.4265,  -4.7104,   0.0000,&
    0.2508,   7.6815, 302.6657,   2.3942,  -4.3841,   0.0000,&
    0.2647,   9.4439, 280.6886,   2.3159,  -4.3586,   0.0000,&
    0.2508,   7.6009, 317.4093,   2.4585,  -4.2027,   0.0000,&
    0.2763,   8.4109, 221.8845,   2.3181,  -4.3788,   0.0000,&
    0.2597,   8.1544, 314.2340,   2.4369,  -4.1116,   0.0000,&
    0.2838,   7.6206, 227.8548,   2.5112,  -5.3451,   0.0000,&
    0.2529,   7.6143, 319.1089,   2.4686,  -4.2939,   0.0000,&
    0.2863,   7.3603, 233.3389,   2.5284,  -5.4036,   0.0000,&
    0.2373,   8.0942, 270.6947,   2.4248,  -4.2093,   0.0000,&
    0.2432,   7.8549, 277.7519,   2.2351,  -3.1838,   0.0000,&
    0.2716,   8.0236, 250.6939,   2.4197,  -4.8222,   0.0000,&
    0.2474,   8.2434, 319.6708,   2.3972,  -3.9519,   0.0000,&
    0.2282,   8.8870, 291.3247,   2.2475,  -4.1677,   0.0000,&
    0.2470,   8.2653, 275.6075,   2.3856,  -4.7364,   0.0000,&
    0.2777,   7.2214, 187.9890,   2.2508,  -3.7746,   0.0000,&
    0.2508,   7.6815, 302.6657,   2.3942,  -4.3841,   0.0000,&
    0.2829,   8.0457, 335.9697,   2.5908,  -5.3846,   0.0000,&
    0.2455,   7.5807, 315.8587,   2.4644,  -4.3065,   0.0000,&
    0.2848,   8.3361, 371.8639,   2.7386,  -5.5083,   0.0000,&
    0.2589,   7.6460, 318.9092,   2.4717,  -4.2794,   0.0000,&
    0.2266,   7.5365, 303.8323,   2.3282,  -3.4184,   0.0000/)
    
  if(rep>100) then
   write(*,*) 'ERROR in BSV19_EXP model. It has only 100 replicas. Central replica is set'
   rep=0
  end if
    
 ReplicaParameters=1d0*replicas((rep+2)*6+1:(rep+2)*6+6)
 
 end function ReplicaParameters
  
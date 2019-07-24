!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!			Model for unpolarized TMD evolution for BSV19
!
!			corresponds to bb* model
!			DNP=Dpert(b*)+g bb*
!			zeta=zetaPert(b) exp[-b2/BB]+zetaSL(b)(1-exp(-b2/BB)
!
!			Requres two NP parameters (initated by best values)
!
!				A.Vladimirov (11.07.2019)
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! USER DEFINED FUNCTIONS   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
 
  !!!!!! Write nessecery model intitialization.
  subroutine ModelInitialization()  
    real*8,dimension(1:NPlength):: InitVar
    integer::i
    if(NPlength<2) then
      write(*,*) 'arTeMiDe.TMDR-model: Number NP parameters for TMDR has less then 2'
      write(*,*) 'Evaluation STOP'
      stop
    end if
    !!!! hard core set of evolution parmeters
    !!!! to secure the model
    EvolutionType=3
    
    InitVar(1:2)=ReplicaParameters(-2)
    if(NPlength>2) then
     do i=3,NPlength
      InitVar(i)=0d0
     end do
    end if
    
    !!! we also initialize the variables
    call TMDR_setNPparameters(InitVar)
    
  end subroutine ModelInitialization 
  !!! This is the rapidity anomalous dimension non-pertrubative model
  !!! In your evaluation take care that the saddle point is inside the pertrubative regeme
  !!! Use function Dpert(mu,b,f) for D pertrubative, use Dresum for D resum
  !!! use non-pertrubative parameters NPparam(1...)
 function DNP(mu,b,f)
 real*8::DNP,mu,b
 integer::f
 real*8::bSTAR
 
  bSTAR=b/SQRT(1+b**2/NPparam(1)**2)
  DNP=Dresum(mu,bSTAR,1)+NPparam(2)*b*bSTAR!!!! D*+gK b b*, it smoother turns perturbative to b^2 assimptotic
  
 end function DNP
  
 !! This is the non-pertrubative shape of zeta_mu line.
 !! It MUST follow the equipotential line in pertrubative regime (at small-b), at the level pf PT accuracy.
 !! Otherwice, your evolution is completely broken.
 !! DO NOT modify it if you do not understand what does it mean!
 !!
 !!! Use function zetaMUpert(mu,b,f) for zetamu pertrubative, use zetaMUresum for zetaMu resumed
 !!! use non-pertrubative parameters NPparam(1...)
 !!
 !! Typical form of it is just zetaMUpert(mu,b,f), if b* is used then zetaMUpert(mu,b^*,f)
 !! The large-b deviation from the "true" line is the part of NP model :)
 function zetaNP(mu,b,f)
 real*8::zetaNP,mu,b
 integer::f
 real*8::zz
 
  zz=Exp(-b**2/NPparam(1)**2)
  zetaNP=zetaMUpert(mu,b,f)*zz+zetaSL(mu,b,f)*(1d0-zz)
 end function zetaNP
 
 !!! this is the table of replica prameters extracted in fit BSV19.
 !!! -2 is suggested for initialization replica
 !!! -1 is the best fit
 !!! 0 is the mean reaplics
 !!! 1 -- 100 replicas
 function ReplicaParameters(rep)
 integer::rep
 real*8::ReplicaParameters(1:2)
 real,parameter,dimension(1:206)::replicas=(/ &
  1.54728,  0.04678,& !!! mean
  2.1203,   0.0322,&  !!! best
  1.54728,  0.04678,&!!! mean
  1.4668,    0.0534 ,&
  1.5718,    0.0377 ,&
  1.6820,    0.0304 ,&
  1.7806,    0.0380 ,&
  1.5559,    0.0383 ,&
  1.6997,    0.0358 ,&
  1.7607,    0.0384 ,&
  2.1320,    0.0305 ,&
  2.2565,    0.0245 ,&
  1.8099,    0.0347 ,&
  1.1602,    0.0796 ,&
  1.1079,    0.0853 ,&
  1.3646,    0.0540 ,&
  1.4518,    0.0549 ,&
  1.6316,    0.0350 ,&
  1.5702,    0.0373 ,&
  1.3328,    0.0559 ,&
  1.5412,    0.0389 ,&
  1.7401,    0.0357 ,&
  1.0836,    0.0892 ,&
  1.6892,    0.0348 ,&
  1.6273,    0.0397 ,&
  1.3483,    0.0564 ,&
  1.1983,    0.0676 ,&
  1.2961,    0.0640 ,&
  1.5350,    0.0448 ,&
  1.4936,    0.0394 ,&
  1.1186,    0.0809 ,&
  1.4613,    0.0381 ,&
  0.9936,    0.1057 ,&
  1.4325,    0.0316 ,&
  1.7615,    0.0347 ,&
  1.0524,    0.0922 ,&
  1.2143,    0.0690 ,&
  1.8651,    0.0314 ,&
  2.0660,    0.0251 ,&
  2.6689,    0.0185 ,&
  1.7761,    0.0372 ,&
  1.4227,    0.0483 ,&
  1.7465,    0.0313 ,&
  1.7082,    0.0418 ,&
  1.2096,    0.0641 ,&
  1.6656,    0.0453 ,&
  1.5020,    0.0367 ,&
  1.3716,    0.0565 ,&
  1.5390,    0.0475 ,&
  1.7772,    0.0378 ,&
  1.6895,    0.0392 ,&
  1.1615,    0.0841 ,&
  1.8500,    0.0352 ,&
  1.1803,    0.0632 ,&
  2.1248,    0.0294 ,&
  2.0094,    0.0286 ,&
  1.7417,    0.0391 ,&
  1.6556,    0.0431 ,&
  1.4187,    0.0521 ,&
  1.2256,    0.0644 ,&
  1.7543,    0.0359 ,&
  1.6485,    0.0370 ,&
  1.8551,    0.0354 ,&
  1.5583,    0.0428 ,&
  1.7241,    0.0380 ,&
  1.6506,    0.0392 ,&
  1.9583,    0.0338 ,&
  1.5040,    0.0433 ,&
  1.8421,    0.0340 ,&
  1.7806,    0.0365 ,&
  1.6440,    0.0384 ,&
  1.9245,    0.0325 ,&
  1.2185,    0.0683 ,&
  1.8074,    0.0333 ,&
  1.1371,    0.0787 ,&
  1.6655,    0.0382 ,&
  1.1309,    0.0757 ,&
  1.7553,    0.0366 ,&
  1.4834,    0.0359 ,&
  1.8607,    0.0343 ,&
  1.2446,    0.0618 ,&
  1.0311,    0.0919 ,&
  1.2005,    0.0626 ,&
  1.1689,    0.0652 ,&
  1.4470,    0.0508 ,&
  1.1336,    0.0826 ,&
  1.4613,    0.0381 ,&
  1.4274,    0.0356 ,&
  1.4204,    0.0386 ,&
  1.5690,    0.0397 ,&
  1.7061,    0.0339 ,&
  1.6382,    0.0353 ,&
  1.5035,    0.0372 ,&
  1.3482,    0.0581 ,&
  1.5025,    0.0382 ,&
  1.4248,    0.0355 ,&
  1.4473,    0.0364 ,&
  1.2482,    0.0595 ,&
  1.7281,    0.0321 ,&
  1.4289,    0.0434 ,&
  1.3195,    0.0615 ,&
  1.4068,    0.0483 ,&
  1.8099,    0.0347 /)
  
 ReplicaParameters=1d0*replicas((rep+2)*2+1:(rep+2)*2+2)
 
 end function ReplicaParameters

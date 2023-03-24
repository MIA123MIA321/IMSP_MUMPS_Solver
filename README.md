# IMSP_MUMPS_Solver
MUMPS Solver for the following 2D Inverse medium scattering problem(**IMSP**)  
  
<div align=center>
<img src="https://latex.codecogs.com/svg.image?\begin{aligned}\Delta&space;\phi&plus;k^2(1&plus;q(x))&space;\phi&space;&&space;=0&space;\\\Delta&space;\phi^i&plus;k^2&space;\phi^i&space;&&space;=0&space;\\\phi&space;&&space;=\phi_0&plus;\psi&space;\\\Delta&space;\psi&plus;k^2(1&plus;q)&space;\psi&space;&&space;=-k^2&space;q&space;\phi^i\end{aligned}" >
</div>

- $\phi_0$ : total field
- $\phi^i$ : inident field
- $\psi$ : scattered field
- $q$ : scatterer, with compact support in $\mathbb{R}^2$  
## Boundary Condition
**Summerfield Radiation Condition**  

<div align=center>
<img src="https://latex.codecogs.com/svg.image?\lim&space;_{r&space;\rightarrow&space;\infty}&space;r^{\frac{1}{2}}\left(\frac{\partial&space;\psi}{\partial&space;r}-i&space;k&space;\psi\right)=0,&space;\quad&space;r=|x|" >
</div>  

Reduce the problem by an artificial surface: [First-order Absorbing Boundary Condition](https://www.math.purdue.edu/~lipeijun/paper/2005/Bao_Li_IP_2005.pdf)  

<div align=center>
<img src="https://latex.codecogs.com/svg.image?\frac{\partial&space;\psi}{\partial&space;\nu}-i&space;k&space;\psi=0,&space;\quad&space;\text&space;{&space;on&space;}&space;\partial&space;\Omega" >
</div>

## Forward problem
For fixed $\phi^i,q,k$  

<div align=center>
<img src="https://latex.codecogs.com/svg.image?\begin{aligned}\Delta&space;\psi&plus;k^2(1&plus;q)&space;\psi&space;&&space;=-k^2&space;q&space;\phi^i&space;\quad&space;\text&space;{&space;in&space;}&space;\Omega&space;\\\frac{\partial&space;\psi}{\partial&space;y}-i&space;k&space;\psi&space;&&space;=0,&space;\quad&space;\text&space;{&space;on&space;}&space;\partial&space;\Omega\end{aligned}">
</div>

Induce  


<div align=center>
<img src="https://latex.codecogs.com/svg.image?\psi=\mathcal{F}_0(q)\left(-k^2&space;q&space;\phi^i\right)=-k^2&space;\mathcal{F}_0(q)\left(q&space;\phi^i\right)&space;\triangleq&space;\mathcal{F}_k(q)\left(\phi^i\right)">
</div>

## Inverse problem
Determine the scatter $q(x)$ from the measurements of $\psi|_{\partial \Omega}$  
### Incident Wave (plane wave)

<div align=center>
<img src="https://latex.codecogs.com/svg.image?\phi^i(x,y)&space;=&space;\exp^{i(k_1&space;x&space;&plus;&space;k_2&space;y)},&space;k_1,k_2&space;\in&space;\mathbb{R},&space;k_1^2&plus;k_2^2&space;=&space;k^2">
</div>

Uniformly, Define $\phi^i$ from $m$ different angles:  

<div align=center>
<img src="https://latex.codecogs.com/svg.image?\phi_j^i(x,y)=\exp^{ik(x\cos(\frac{2j}{m})&plus;y\sin(\frac{2j}{m}))},j&space;=&space;0,1,\ldots,m-1">
</div>

### Optimization Model

<div align=center>
<img src="https://latex.codecogs.com/svg.image?\begin{aligned}\min&space;_q&space;J_{m,\{k\}}(q)&space;&&space;=\frac{1}{2m}&space;\sum_{k&space;\in\{k\}}&space;\sum_{j=0}^{m-1}\left\|M&space;\mathcal{F}_k(q)\left(\phi_j^i\right)-\operatorname{Data}\left(q_t\right)\left(k,&space;\phi_j^i\right)\right\|_2^2&space;\\&&space;\approx&space;\frac{1}{2m}&space;\sum_{k&space;\in\{k\}}&space;\sum_{j=0}^{m-1}\left\|M&space;\mathcal{F}_k(q)\left(\phi_j^i\right)-M&space;\mathcal{F}_k\left(q_t\right)\left(\phi_j^i\right)\right\|_2^2&space;\\&&space;=\frac{1}{2m}&space;\sum_{k&space;\in\{k\}}&space;k^4&space;\sum_{j=0}^{m-1}\left\|M&space;\mathcal{F}_0(q)\left(q&space;\phi_j^i\right)-M&space;\mathcal{F}_0\left(q_t\right)\left(q_t&space;\phi_j^i\right)\right\|_2^2\end{aligned}">
</div>

- $M$ : the matrix to generate $\psi|_{\partial \Omega}$ from $\psi$
- $q_t$ : the ground truth of the scatterer $q$
- $\operatorname{Data}(q_t)$ : $\psi|_{\partial \Omega}$ aroused by $q_t$

## Method
- Solve the Forward problem(PDE) by **FDM** to generate the equation and **MUMPS** to solve it
- Derive $\frac{\partial \mathscr{F}_k}{\partial q}$ and $\frac{\partial J}{\partial q}$ through **functional analysis** 
- Use **L-BFGS** to solve the total optimization problem

## Scatterer
<div align=center>
<img src="pic/scatterer.jpg">
</div>

## Parameters
- k : the frequency of the incident wave
- m : the number of incident angles
- maxq : the strength of the scatterer
- nosielevel : the nosie level of the collected boundary data  
We use a grid of 64 on $[0,1]^2$ to discrete the problem. The Initial gauess of $q$ is zero.  
As for **L-BFGS**, we set ```gtol = 1e-10``` and ```maxiter=50```.
## Usage
- [MUMPS Install](https://github.com/MIA123MIA321/MUMPS-Install)
- ```bash scripts/xxx.sh```
## Results
- iter : iter after iteration termination
- $J_0$ : initial value of $J$
- rel-J : $J_{res}$ / $J_0$
- rel-err : relative error between $q_{res}$ and $q_t$ after iteration termination
- time : time per iter after iteration termination



### T shape
| k | m | maxq | noise | iter | $J_0$| rel-J |rel-err | time |
|:-----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
|**80**|**64**|**0.1**| **0%**|**50**|**1.71e2**|**5.28e-7**| **8.61%** | **4.77** |
|**10,20,40,60,80**| | | | |**3.13e2**|**6.16e-7**|**8.63%** |**19.27**|
|**40,60,80**| | | | |**2.99e2**|**6.07e-7**|**8.62%**|**12.59**|
|**60,80,100**| | | | |**6.01e2**|**5.28e-8**|**1.05%**|**12.61**|
| |**16**| | | |**1.72e2**|**1.93e-5**|**13.70%**|**1.18**|
| |**32**| | | |**1.71e2**|**1.00e-6**|**8.65%**|**2.14**|
| |**128**| | | |**1.71e2**|**4.86e-7**|**8.61%**|**8.54**|
| | |**0.01**| | |**2.15e1**|**4.39e-7**|**9.48%**|**5.71**|
| | |**0.3**| | |**1.74e2**|**5.72e-2**|**154.17%**|**5.44**|
| | |**0.5**| | |**5.62e2**|**1.98e-1**|**138.90%**|**5.38**|
| | |**0.7**| | |**4.84e1**|**1.35e-1**|**116.30%**|**5.62**|
| | |**1.0**| | |**3.47e1**|**1.39e-1**|**113.09%**|**5.52**|
| | | |**0.1**| |**1.75e2**|**2.57e-2**|**25.75%**|**5.75**|
| | | |**0.3**| |**2.14e2**|**1.87e-1**|**71.51%**|**5.44**|
| | | |**0.5**| |**2.91e2**|**3.81e-1**|**134.54%**|**5.43**|


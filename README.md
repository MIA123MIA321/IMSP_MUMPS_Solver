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
<img src="https://latex.codecogs.com/svg.image?\phi_j^i(x,y)=\exp^{ik(x\cos(\frac{2j}{m})&plus;y\sin(\frac{2j}{m}))},j&space;=&space;0,1,\ldots,m">
</div>

### Optimization Model

<div align=center>
<img src="https://latex.codecogs.com/svg.image?\begin{aligned}\min&space;_q&space;J_{m,\{k\}}(q)&space;&&space;=\frac{1}{2}&space;\sum_{k&space;\in\{k\}}&space;\sum_{j=0}^{m-1}\left\|M&space;\mathcal{F}_k(q)\left(\phi_j^i\right)-\operatorname{Data}\left(q_t\right)\left(k,&space;\phi_j^i\right)\right\|_2^2&space;\\&&space;\approx&space;\frac{1}{2}&space;\sum_{k&space;\in\{k\}}&space;\sum_{j=0}^{m-1}\left\|M&space;\mathcal{F}_k(q)\left(\phi_j^i\right)-M&space;\mathcal{F}_k\left(q_t\right)\left(\phi_j^i\right)\right\|_2^2&space;\\&&space;=\frac{1}{2}&space;\sum_{k&space;\in\{k\}}&space;k^4&space;\sum_{j=0}^{m-1}\left\|M&space;\mathcal{F}_0(q)\left(q&space;\phi_j^i\right)-M&space;\mathcal{F}_0\left(q_t\right)\left(q_t&space;\phi_j^i\right)\right\|_2^2\end{aligned}">
</div>

- $M$ : the matrix to generate $\psi|_{\partial \Omega}$ from $\psi$
- $q_t$ : the ground truth of the scatterer $q$
- $\operatorname{Data}(k,q_t)$ : $\psi|_{\partial \Omega}$ aroused by $q_t$ w.r.t. $k$

## Results


# IMSP_MUMPS_Solver
MUMPS Solver for the following 2D Inverse medium scattering problem(**IMSP**)  
  
<div align=center>
<img src="https://latex.codecogs.com/svg.image?\begin{aligned}\Delta&space;\phi&plus;k^2(1&plus;q(x))&space;\phi&space;&&space;=0&space;\\\Delta&space;\phi^i&plus;k^2&space;\phi^i&space;&&space;=0&space;\\\phi&space;&&space;=\phi_0&plus;\psi&space;\\\Delta&space;\psi&plus;k^2(1&plus;q)&space;\psi&space;&&space;=-k^2&space;q&space;\phi^i\end{aligned}" >
</div>

- $\phi_0$: total field
- $\phi^i$: inident field
- $\psi$: scattered field
- $q$: scatterer, with compact supportt in $\mathbb{R}^2$  
## Boundary Condition
**Summerfield Radiation Condition**  
<div align=center>
<img src="https://latex.codecogs.com/svg.image?\lim&space;_{r&space;\rightarrow&space;\infty}&space;r^{\frac{1}{2}}\left(\frac{\partial&space;\psi}{\partial&space;r}-i&space;k&space;\psi\right)=0,&space;\quad&space;r=|x|" >
</div>
Reduce the problem by an artificial surface:  
[12](www.baidu.com)
<div align=center>
<img src="https://latex.codecogs.com/svg.image?\frac{\partial&space;\psi}{\partial&space;\nu}-i&space;k&space;\psi=0,&space;\quad&space;\text&space;{&space;on&space;}&space;\partial&space;\Omega" >
</div>

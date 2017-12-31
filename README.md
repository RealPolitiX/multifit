# multifit
The repo consists of two sets of Matlab routines for fitting transient absorption data.


### **multioscfit**
Iterative fitting of a single free induction decay time trace into a sum of exponential decay-modulated (co)sinusoids. The routine uses starting point re-initialization to find a close fit in a much faster and more reliable way than conventional single-starting approach.



Fitting to a model of the type,

$$S(\{A_i, \tau_i, \nu_i, \phi_i\}_{i=1}^N, t_0: t) = \sum_{i=1}^{N}A_i \exp({-t/\tau_i}) \sin[\nu_i (t - t_0) + \phi_i]$$

or $$\sum_{i=1}^{N}A_i \exp({-t/\tau_i}) \cos[\nu_i (t - t_0) + \phi_i]$$ ($$N$$ = 1, 2, ...).



The background removal (multi-exponential decay type) may be carried out using the global fitting approach (see following section).



### **globalfit**
Global fitting of multi-exponential decay relaxation dynamics with a Gaussian impulse response (under construction...)



Fitting to a model of the type,

```
![alt text](../accessories/eq_globalfit.gif "GlobalFit")
```


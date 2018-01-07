# multifit
The repo consists of two sets of Matlab routines for fitting transient absorption data.


### **multioscfit**
Iterative fitting of a single free induction decay time trace into a sum of exponential decay-modulated (co)sinusoids. The routine uses starting point re-initialization to find a close fit in a much faster and more reliable way than conventional single-starting approach.



Fitting to a model of the type,

$$S(\{A_i, \tau_i, \nu_i, \phi_i\}_{i=1}^N, t_0: t) = \sum_{i=1}^{N}A_i \exp({-t/\tau_i}) \sin[\nu_i (t - t_0) + \phi_i]$$

or $$\sum_{i=1}^{N}A_i \exp({-t/\tau_i}) \cos[\nu_i (t - t_0) + \phi_i]$$ ($$N$$ = 1, 2, ...).



The background removal (multi-exponential decay type) may be carried out using the global fitting approach (see following section).



### **globalfit**
Global fitting of multi-exponential decay relaxation dynamics with a Gaussian impulse response.

Goal: achieve small confidence interval on the evaluation of parameters (e.g. time constants) by fitting simultaneously over a large number of traces.



Fitting to a model of the type,

![Alt text](https://github.com/RealPolitiX/multifit/blob/master/accessories/eq_globalfit.gif "GlobalFit")

Operation steps:

1. __Construct fitting model__ (e.g. DecayModel or use a model constructor like [`constructExpDecayModel`](https://github.com/RealPolitiX/multifit/blob/master/globalfit/generic_framework/constructExpDecayModel.m)).

2. __Single-trace fitting__ to provide feasible (can be carried out using Matlab's [cftool](https://de.mathworks.com/help/curvefit/curvefitting-app.html) interactive interface).

3. __Construct initial guesses and (upper and/or lower) bounds__, if necessary, for every fitting parameter.

   function to use: [`fvconstruct`](https://github.com/RealPolitiX/multifit/blob/master/globalfit/fvconstruct.m)

4. __Construct the minimizer__ by plugging the model, initial guesses (and bounds) into it.

   minimizer of choice for least-square problems: Levenberg-Marquardt, trust region reflective

   functions to use: lsqcurvefit, lsqnonlin, etc.

5. __Run the minimizer and check for results__ numerically or graphically. Modify initial guesses, bounds, fitting options, if needed, to get a better fit.

6. __Calculate the 95% confidence intervals (CIs)__ for all fitting parameters.

   function to use: [`nlparci`](https://www.mathworks.com/help/stats/nlparci.html) (need the Jacobian obtained from minimizers)

7. __Distribute the fitted parameters and CIs__.

   function to use: [`vardist`](https://github.com/RealPolitiX/multifit/blob/master/globalfit/vardist.m)

8. __Construct dictionary/structure to store fitted parameters and CIs__.

   function to use: [`dictConstructor`](https://github.com/RealPolitiX/multifit/blob/master/globalfit/dictConstructor.m)
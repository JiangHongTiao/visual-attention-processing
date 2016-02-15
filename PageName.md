# Introduction #



# Details #

## A Special Accessor and A special Mutator ##

Operators such as +,-,/,~= are operators which call functions in orders to execute formulas.
We are going to examine subsref.m and subasgn.m operators.

### A Short Side Trip to Examine Overloading ###

> Each operator corresponds to a functional call, e.g + => plus.m; <= => le.m. We can redefine or overload the function call.

> In the overloading concepts, there are two basic functions: overloaded function, overloading function.

> Overloading activities needs experience but there are few hard-and-fast rules
  * The behaviour of tailored functions can be inferred from original functions.
  * The argument syntax need to be similar to the original argument syntax.

#### Superiorto and Inferiorto ####

> MATLAB always use one input argument "this" ???
> All classes in MATLAB are first created in the same level and users can define their relative priority.
> If all arguments have the same type, MATLAB uses the type of the very first argument.
> Classes that overload operators usually need to increase their priority relative to built-in types.
> Risks of calling both the tailored and built-in functions at the same time can be avoided by clearly defining what function is more superior by **superiorto('double')**.

#### The built-in function ####

> Using [y1, ..., yn] = builtin('function\_name',x1, ..., xn) in order to call the original function. But it allows the violation of encapsulation.

### Overloading the Operators subsref and subasgn ###

., (), {} are operators with following names:: dot-reference, array-reference, and cell-reference syntax map to subsref.m and subsasgn.m . They are the most important operators encountered because it helps to create an easy-to-use syntax.

> Overloading subsref.m and subsasgn helps us the replace get / set by familiar dot operation but does not break the rule of encapsulation.

> The basic function defintion of subsref.m & subsasgn.m can be written as
> function varargout = subsref(this, index)
> function this = subsasgn(this, index, varargin)

  * **this** is the first input argument so we do not need to use superior and inferior.
  * **index** is the packaged version of the operator and indices supporting multioperators and multilevels.
  * **substruct** can be used to create the special packaging so **index** format is called **substruct**.

#### Dot-Reference Indexing ####

```
 b = a.field 
 b = subsref(a,substruct('.','field'));
 a.field = b;
 a = subsasgn(a, substruct('.','field'),b);
```
> A 1:1 mapping between public and private members: varargout = {this.(index(1).subs)};. But it is too simple and lacks of errors and invalid input checking.

#### Subsref Dot-Reference, Attempt 1 ####

> Using the operator loading to create an illusion direct access to variable. The cell-array this still exists as structures of class field names.

#### A New Interface Definition ####

> All get,set, ColorRGB are replaced by dot-array functions, so it provides new interfaces.

#### Subsref Dot-Reference, Attempt 2: Separating Public and Private Variable ####

> The real purpose of subsref and subasgn is to support encapsulation by providing easy-to-use interace.

> subsasgn uses a switch on the dot-reference name and cases inside subsasgn guard against direct mutation.
> We can include the public member variable in **subsref**, **subsasgn** switch, and both. Variables in **subsref** is readable and variables in **subsasgn** is writable.
> Up to now, variables are still one-one, public to private.
#### Subsref Dot-Reference, Attempt 3: Beyond One-to-One, Public-to-Privatet ####

> Replace the RGB color mode by HSV color mode and using the color mode conversion to gives the RGB output.

#### Subsref Dot-Reference, Attempt 4: Multiple Indexing Levels ####

> For scalar objects, all index are processed; and for nonscalar projects, the presence of index levels beyond the first dot-reference will throw an errors

#### Subsref Dot-Reference, Attempt 5: Operator Conversion Anomaly ####

> The problem is that access operator conversion is different from built-in type and user-defined type.
> The conversion from access-operator synteax into the equivalent function call does not always preserve the correct value of nargout.
> The work-around for the anomaly is to repackage the individual cells of varargout into varargout{1}.**#### Subasgn Dot-Reference ####**

#### Array Reference Indexing ####

#### Subsref Array-reference ####
#### Subasgn Array-reference ####
#### Cell-reference Indexing ####
## The Test Drive ##

> The convenient interface is created to mimics the way MATLABs structure can be indexed.
> We have not exposed any private variables.
> The interface functions subsref and subasgn stands between public and private variable.

## Summary ##

  * Each case of dot-access switch corresponds to public variable
  * Use MATLAB built-in function whenever you have chances
  * Operation syntax and associated functional form are identical
  * Superiorto, inferiorto relative to argument lists.
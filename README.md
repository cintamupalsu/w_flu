# WuhanFlu

This is the sample application for recording health database

## License

This software is licensed under the "Anyone But Richard M Stallman"
(ABRMS) license, described below. No other licenses may apply.


--------------------------------------------
The "Anyone But Richard M Stallman" license
--------------------------------------------

Do anything you want with this program, with the exceptions listed
below under "EXCEPTIONS".

THIS SOFTWARE IS PROVIDED "AS IS" WITH NO WARRANTY OF ANY KIND.

In the unlikely event that you happen to make a zillion bucks off of
this, then good for you; consider supporting WuhanFlu patient for treatment.


EXCEPTIONS
----------

Richard M Stallman (the guy behind GNU, etc.) may not make use of or
redistribute this program or any of its derivatives.


## Getting started

To get started with the app, clone the repo and then install the needed gems:
```
$ bundle install --without production ```
Next, migrate the database:
```
$ rails db:migrate
```
Finally, run the test suite to verify that everything is working correctly:
```
$ rails test
```
If the test suite passes, you'll be ready to run the app in a local server:
```
$ rails server
```

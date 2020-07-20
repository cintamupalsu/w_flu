# Codomap

We address the pandemic problem to prevent the spreading of disease and also trace the footprint of disease. As we are now in the middle of COVID pandemic which has been spread widely, we would like to build an application to collect some information which easily exchanges and use between the community to raise an alert among them.

Our purpose is to collects as much as accurate data from the community, starting from the smallest social group such as family and its neighbourhood, offices, small organizations, clinics. It also not close to seeing the chance to introduce this application to more wide groups such as General Hospital, Local Authority, Municipality, and others.

The applications are integrated, which provides no limit to be used, even for the overseas market. In the beginning, we would like to introduce to IOS user and delivers the benefits of this application. We hope we may see the result by analyzing the collected information from this application and compare it to the social condition. We are also looking for feedback during this trial to make some improvement for better service in the future.

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

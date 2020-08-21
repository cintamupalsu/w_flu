# Codomap

We address the pandemic problem to prevent the spreading of disease and also trace the footprint of disease. As we are now in the middle of COVID pandemic which has been spread widely, we would like to build an application to collect some information which easily exchanges and use between the community to raise an alert among them.

Our purpose is to collects as much as accurate data from the community, starting from the smallest social group such as family and its neighbourhood, offices, small organizations, clinics. It also not close to seeing the chance to introduce this application to more wide groups such as General Hospital, Local Authority, Municipality, and others.

The applications are integrated, which provides no limit to be used, even for the overseas market. In the beginning, we would like to introduce to IOS user and delivers the benefits of this application. We hope we may see the result by analyzing the collected information from this application and compare it to the social condition. We are also looking for feedback during this trial to make some improvement for better service in the future.

This project has been submitted to IBM Call for Code 2020.

## License

Copyright 2020 SBS Information System (SBS情報システム)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Getting started

To get started with the app, clone the repo and then install the needed gems:
```
$ bundle install --without production
```
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

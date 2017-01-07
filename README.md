## Contract Testing

Demonstrates Contract Testing in [Ruby](https://www.ruby-lang.org/) based on [The World's Best Intro to TDD](http://online-training.jbrains.ca/courses/wbitdd-01/lectures/139945).

I was interested in Contract Testing as a mechansim to avoid API drift. There are two branches in this repository that demonstrates this problem:

1. [api-drift](https://github.com/nicholasjhenry/wbitdd/tree/api-drift)
2. [prevent-api_drift](https://github.com/nicholasjhenry/wbitdd/tree/prevent-api-drift)

This source code was used as a discussion with [J. B. Rainsberger](https://twitter.com/jbrains) over a Google Hangout. Unfortunately, the
discussion wasn't recorded or notes taken. However, they did result in the following tweets from Joe:

> A student at http://online-training.jbrains.ca/courses/wbitdd-01/ … has helped me clarify the correspondence btw test doubles in collaboration tests and contract tests.

https://twitter.com/jbrains/status/612042806362681345

> Creation methods in contrast tests help enumerate the classes of equivalence in the contract's semantics. How did I not see that before?!

https://twitter.com/jbrains/status/611964232351899650

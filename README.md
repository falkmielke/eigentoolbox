
# Eigentoolbox

<!-- badges: start -->
  [![R-CMD-check](https://github.com/falkmielke/eigentoolbox/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/falkmielke/eigentoolbox/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->


The goal of eigentoolbox is to perform Eigenanalyses.
What did you think?

Besides, I use this to learn R package building. 
I started off with good intentions.
But learning package building is hard work. 

Turns out, it is especially hard in R.


## Python *versus* R
*Rant ON.*

Occasionally, for example at lunchtime with my colleagues, genuinely cool people, who have a laptop full of hexagonal stickers, I forget what an annoying "programming" "language" R is.
But with this package, it came back right *in my face*.
Here some steam.


Today, my first package building day in R ...
was arguably my **most frustrating programming experience ever**. 
And, mind, I learned `basic`, `tp`, `excel`, `java` and `matlab` before at some point (in that order).


The frustration has reasons, and seems to be here to stay:
Normally, when I am stuck on programming, there is a point when I find the overlooked bug (often learned a novel concept on the way), finally all the gears in the motor move and the thing works as intended, and my brain fires dopamine.
You get paid off for enduring your frustration.
With R, and `devtools`, I was quite happy to get a simple PCA to work - yet the "bugs" were just syntax details the linter didn't like!
Acknowledged: this is biased, because I had implemented that algorithm a couple of times before.
The core of Eigenanalysis is tiny.
Still, net outcome: nothing of general relevance learned, nothing improved, just fought compliance bullshit.
I meticulously noted all the steps of package generation, and still I have exactly zero confidence that `devtools::check()` will succeed after that hour of knitting on my next project. 

What remains is a reluctance to ever build a package in R again.


There are many aspects that made my mood explode today.
It could have been a good day.
Just take Python.

- It can use proper OOP tricks.
- It can be imported from the file, as if it were a package.
- I can give it an alias upon import.
- Speaking of it: we simply `import`. `library`'s are for geeks, `require` for junkies, `namespace` for bigwigs. I do not feel any of these is right.
- `NAMESPACE` my ass, we call that `scope`, and it has a logic to it (inner > outer; later import overrides).
- I could write and run tests as I like, no need to formalize and fail like `devtools::test()`.
- If I would want documentation helpers, there's [plenty available](https://wiki.python.org/moin/DocumentationTools) and certainly there's one less annoying than `roxygen2`.
- I never needed `devtools::check()`. It is the pinnacle of compliance.
- I can freely choose my IDE, which is one that improves my efficiency instead of exchanging base flaws for its own ones (*FCK RSTD*).


I am grumpy, but am I unfair?
Do I expect too much?
I do not think so.
For example, the `roxygen2` way of documenting stuff is much better than writing any `.Rd` file yourself ("Have you ever written an `Rd`?" // "I do, but I would never want to do that again." *T.O.*).
Yet just because the Pet Stop Boys are better than Justine Biber does not mean that you would want to `@importFrom` either of them, right?
*I am more of a punk anyways.*
The problem with `Roxy` is that she tries to be many things at once.
*Roxy* defines imports and exports in the scope of the package.
WTF?!
And then there is exactly *one* way of getting these import tags to the package correctly.
Yes, that *is* necessary: we need consistency of the `roxygen2` tags and a list in the `DESCRIPTION`.
Why both? 
Don't ask me.


Why do we need `usethis` (silly name, btw), could we not just improve the base procedure, instead?
Why do we need `tibble`s, could we not just improve data frames?
In part, this is a community failing to converge on good practices, a "zen of R".
And because of that situation, with R, I constantly get forced into inefficient workflows and compliance bullshit.
> This is how we do it, because this is the way to do it in R.

Does anyone ever ask *why* something is some way in R, and change it because it was a shitty idea?
Is it because HW "look-who-writes-the-longest-pipes" said so?
Why do we silently accept that `x` and `y` are classified as *aesthetics* of a plot? 
They are the freaking *data*!
*Aesthetic* actually derive from layout, color, symbols, spacing.
(Something that a `theme_default()` should handle in a good way, shouldn't it?)

There are so many misused words in R that I fear permanent brain miswiring if I have to keep using it.
[We are fucked.](https://theonion.com/expert-explains-why-essentially-youre-fucked)


Calm down, Falk. 
It is software. 
We should be able to tune it to our needs.
*Or, if we cannot, maybe it is flawed by design.*
There are conventions and syntax restrictions in Python or C as well.
*But they usually empower you, because they are few, consistent, logical, and helpful (e.g. by shifting runtime errors to compile time).*
In python, there are only a handful of keywords to know: `def`, `class`, control flow.
In R, syntax restrictions come from the limitations of the software.
And, if you dig deeper, you will find that all the good R packages are actually written in C.


Where I used to think (e.g. on `@descriptors`, `generators`, any of the advanced topics)
> Hmmm, that's clever!
R, at its full glory, makes me think
> Hmm, that makes another shit less shitty, but it is still not what I would want it to do.

Nobody in their sane minds would choose R, if they had a choice.
The reason we still use it that someone else in the past said "it is good".


> Oh, how I miss Python...


*Rant OFF.*


As supporting evidence, I included my previous python code in `./src/EigenToolbox.py`. 
It is just so much better, simpler, more useful, than this whole package.
And it took me half the time to build.



## Installation

You can install the development version of eigentoolbox from [GitHub](https://github.com/) with:

```{r, eval=FALSE}
remotes::install_github("falkmielke/eigentoolbox")
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r, eval=FALSE}
library(eigentoolbox)
## basic example code
```

## Documentation

- https://r-pkgs.org
- https://coding-club.inbo.be



## TODO

- [ ] option to standardize
- [ ] dimensionality reduction
- [ ] trilobite data [as data](https://r-pkgs.org/data.html)
- [X] quick plot pca via s3 generic methods
- [ ] ~~inbomd~~ (...is for reports, not vignettes)

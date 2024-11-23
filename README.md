
# Eigentoolbox

The goal of eigentoolbox is to perform Eigenanalyses.
What did you think?


Besides, I use this to learn R package building. 
I started off with good intentions.
But learning package building is hard work. 

Turns out, it is especially hard in R.


## Python *versus* R
*Rant ON.*

Occasionally, for example at lunchtime with my colleagues - genuinely cool people, who have laptops full of hexagonal stickers - I forget what an annoying "programming" "language" R is.
But with this package, it came back right *in my face*.
Here some steam.


Today, my first package building day in R ...
was arguably my **most frustrating programming experience ever**. 
And, mind, I learned `basic`, `tp`, `excel`, `java` and `matlab` before at some point (in that order).


The frustration has reasons, and seems to be here to stay:
Normally, when I am stuck on programming, there is a point when I find the overlooked bug (often learned a novel concept on the way).
Finally, all the gears in the motor move and the thing works as intended, and my brain fires dopamine.
You get paid off for enduring your frustration.
With R, and `devtools`, I was also quite happy to get a simple PCA to work - yet the "bugs" I was hunting were just syntax details the linter didn't like. 
Self-made problems.

Acknowledged: this work was biased towards more structure and less content, because I had implemented that algorithm a couple of times before.
The core of Eigenanalysis is tiny.
Still, net outcome: nothing of general relevance learned, nothing improved, just fought compliance bullshit.
> I meticulously noted all the steps of package generation, and still I have exactly zero confidence that `devtools::check()` will succeed after that hour of knitting on my next project. 

What remains is a reluctance to ever build a package in R again.
Of course I will learn the conventions, and adapt my habits. 
But I do not feel like this is going to benefit my general programming skills.


There are many aspects that made my mood explode today.
It could have been a good day.
Just take Python, for comparison.

- It can use proper OOP tricks.
- Code can be imported from any file, as if it was a package - no need to formalize (note: this is not equivalent to `source("script.R")`).
- I can give it an alias upon import, or import only part of it.
- Speaking of import: in Python, we simply `import`. A `library` is a place for geeks, `require` a habit of junkies, `namespace` is for bigwigs. Neither of these options feel attractive to me.
- Speaking of concept overloading: how many `assert`ion packages are there again in R? [Why](https://blog.djnavarro.net/posts/2023-08-08_being-assertive)!?
- `NAMESPACE` my ass, [software engineers call that `scope`](https://en.wikipedia.org/wiki/Scope_(computer_science)), and it has a logic to it (inner > outer; later = override). Let's not get started about the `environment`; I work at an environmental research agency.
- Folder structure in Python is flexible, even though there are meaningful conventions.
- I could write and run tests as I like (and I do), automation is obvious, no need to formalize and fail like `devtools::test()`.
- Parallel processing is real, even if it is actually `asyncio`.
- If I would want documentation helpers, there are [plenty available](https://wiki.python.org/moin/DocumentationTools) and certainly there is one less annoying than `roxygen2`.
- I never needed `devtools::check()`. It is the pinnacle of compliance [BS](https://callingbullshit.org).
- I can freely choose my IDE, which is one that improves my efficiency instead of exchanging base flaws for its own ones (*FCK RSTD*).


Yes, I am grumpy, but am I unfair?
Do I expect too much?
I do not think so.

For example, the `roxygen2` way of documenting code is much better than writing any `.Rd` file yourself ("Have you ever written an `Rd`?" // "I do, but I would never want to do that again." *T.O.*).
Yet just because the Pet Stop Boys are better than Justine Biber does not mean that you would want to `@importFrom` either of them, right?
*I am more of a punk anyways.*
The problem with `Roxy` is that she tries to be many things at once.
*Roxy*, which is supposed to be a documentation tool, defines imports and exports in the scope of the package (i.e. it imports, from a comment-like line, without the explicit call to `library()`).
WTF?!
Then, downstream, there is exactly *one* way of filing these import tags to the package correctly, and it is not obvious: I have to read some kind of book by a guru.
I understand, this is supposed to be good, so that documentation does not get outdated. 
Yes, consistency *is* necessary: we need consistency of the `roxygen2` tags and a list in the `DESCRIPTION`.
But that check should be between a proper, explicit `import` on the one hand, and pachage `requirements.txt` on the other.
In my opinion, this is not a task for the documentation parser.
Don't ask me.
I like (both) the basic ideas of that package. 
Yet the implementation details are causing frustrating.


It is not always in the details.
Often, it is the big picture, too.
OOP is quasi dysfunctional (no multiple inheritance, no interfacing, multiple implementations with meaningless S and R letters, all bad at different aspects), yet on S3, they call this "flexible".
You might think R as rather "functial programming oriented"?
Think again, but please return only one thought at a time!

Or take the actual bread-and-butter tools at our disposal.
Granted, R has `dict`s built into their `c("name" = value)` vectors.
However, the cool thing about python dicts is on the usage side: the ability to subclass them, defaults, magic functions, `**kwargs`; there are also `list`s and `set`s with comprehensive functionality. 
I miss list comprehension. Dict comprehension. Generators...
And ease of use.
I would always prefer `{}` over `c()`. `[]` over `c()`. Occasionally even `()`.
It's mind-boggling that you can put `names(vec) <-` on the left handside; but I never needed it.
If the `__name__` is equal to the `__main__`, I am happy, which is to say that python also has its quirks.
Pythons quirks are often under de hood (e.g. loops are slow), they are like the `bokeh` of a good photo, they are not in front and focus. 
And they are linked to **readability**, and educational advantages; another area where R does not `shiny`.
For one reason or another, Python quirks never bothered me.
> Oh, how I miss my dictionaries.


On we go.
Why do we need `usethis` (silly name, btw), could we not just improve the base procedure, instead?
Why do we need `tibble`s, could we not just improve data frames, or move on to `data.table`s directly?
I heard that the `dplyr` devs change standards infrequently, or all the time, depending on who you ask; you might call this a "living language" or "organic development", yet it is annoying for maintainers (especially for the deceased ones). 

In part, all these might be symptoms of a community failing to converge on good practices, a "zen of R".
*The same community who fail to [find a new timeserver since the old one went down at lest four years ago](https://stackoverflow.com/a/63616156), or to just de-activate the check for "future file timestamps" to leave that for the user.*
And because of that general situation, R repeatedly forces me into inefficient workflows and compliance bullshit.
It actively drains my time. 
> "This is how we do it, not because it is logical, but because this is the way to do it in R."
I left Excel behind for the same reason, long ago.


When was the last time that someone asked *why* something is some way in R, and then changed it from scratch because it was a shitty idea to begin with?
Do we do things just because HW "look-who-writes-the-longest-pipes" said so?
For example, why do we silently accept that `x` and `y` are classified as *aesthetics* of a plot? 
They are the freaking *data*, not the *aesthetics*!
*Aesthetic* (the "nature of beauty and the nature of taste and, in a broad sense, incorporates the philosophy of art", [source: wikipedia](https://en.wikipedia.org/wiki/Aesthetics)) are related to layout, color, symbols, spacing; whereas `x` and `y` are just the table.
(All things that a `theme_default()` should handle in a *good* way, shouldn't it?)

There are so many misused words in R that I fear permanent brain miswiring if I have to keep using it.
[We are fucked.](https://theonion.com/expert-explains-why-essentially-youre-fucked)
Probably, Python has also spoiled my brain: for example, I like accurate indentations, and I am fine with it being enforced on me.
But, back when I learned it, the Python loss-of-freedom felt good, and I could make sense of it (e.g. less need for brackets).
Now, R loss-of-freedom feels like a waste of time, because I do not see the use and logic of conformity.
Acknowledged, this is, for a large part, caused by my spoiled brain.


Calm down, Falk. 
It is just software. 
We should be able to tune it to our needs.
*Or, if we cannot, maybe it is flawed by design?*
There are conventions and syntax restrictions in Python or C as well.
*But they usually empower you, because they are few, consistent, logical, and helpful (e.g. by shifting runtime errors to compile time).*
In python, there are only a handful of keywords to know: `def`, `class`, `assert`, brackets, control flow.
In R, syntax restrictions come from the limitations of the software.
Fun fact: if you dig deeper, you will find that all the good R packages are actually written in C (also in Python, I know, bit then the strength if the snake is its elegance).
And, boy, did I enjoy programming Stan models last week: it is logical, and works as expected; simple, yet powerful; it just does what you say.


Where I used to think (e.g. on `@descriptors`, `generators`, any of the advanced topics):
> Hmmm, that's clever!
R, at its full glory, makes me think
> Hmm, that makes another shit less shitty, but it is still not exactly what I would want it to do.


Nobody in their sane minds would choose R, if they had a choice.
The reason we still use it that someone else in the past said "it is good".


> Oh, how I miss Python...


*Rant OFF.*


As supporting evidence, I included my previous python code in `./inst/EigenToolbox.py`. 
(*Do not ask me what `inst` means..., [I just found that on SO](https://stackoverflow.com/a/30794104).*)
The Python variant is just so much better (as in: simpler to read, more versatile, ...) than this whole package.
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

- [X] quick plot pca via s3 generic methods
- [ ] option to standardize (center+normalize) input data
- [ ] dimensionality reduction
- [ ] trilobite data [as data](https://r-pkgs.org/data.html)
- [ ] why the yaml badge?
- [ ] ~~inbomd~~ (...is for reports, not vignettes)


<!-- badges: start -->
  [![R-CMD-check](https://github.com/falkmielke/eigentoolbox/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/falkmielke/eigentoolbox/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->
*Note: I don't know why one of the functions gave me this dysfunctional badge.*

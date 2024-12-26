# Regular Expressions

## TLDR

```

SPECIAL CHARACTERS IN REGULAR EXPRESSIONS
------------------------------------------
^        start of line
$        end of line
\b       word boundary
\B       non-word boundary
.        any character
[.]      a period, same as \.


OPERATOR HIERARCHY, FROM HIGHEST PRECEDENCE TO LOWEST PRECEDENCE:
------------------------------------------
Parenthesis                            ()
Counters aka repetition quantifiers    * + ? {}
Sequences and anchors                  the ^my end$
Disjunction                            |


REPETITION QUANTIFIERS
------------------------------------------
* match zero or more times
+ match one or more times
? optional match (will be matched at most once)
{n} match exactly n times
{n,} match n or more times
{n,m} match at least n times, but not more than m times
| join two regular expressions, e.g. `abba|cde` matches either the string `abba` or `cde`


DISJUNCTION `[]`
------------------------------------------
[Ww]oodchuck        Woodchuck or woodchuck
[abc]               'a', 'b', or 'c'
[1234567890]        any digit

A RANGE `[]` and `-`
------------------------------------------
[A-Z]        an upper case letter
[a-z]        a lower case letter
[0-9]        a single digit

NEGATION `^` (only when used as first symbol after the open square brace `[` )
------------------------------------------
[^A-Z]    not an upper case letter
[^Ss]     neither 'S' nor 's'
[^.]      not a period (note that only in this case THIS IS A PERIOD, in other cases . stands for 
                        any character)

OPTIONALITY `?`
------------------------------------------
woodchucks?   woodchuck or woodchucks    --> the letter s is optional
colou?r       color or colour            --> the letter u is optional

```

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Basic Usage

**Specify a disjunction of characters with brackets `[]`**

```
Regex               Match
------------------------------------------
[Ww]oodchuck        Woodchuck or woodchuck
[abc]               'a', 'b', or 'c'
[1234567890]        any digit
```

**Specify a range with brackets `[]` and a dash `-`**

```
Regex        Match
------------------------------------------
[A-Z]        an upper case letter
[a-z]        a lower case letter
[0-9]        a single digit
```

**Negate with the caret `^` (only when used as first symbol after the open square brace `[` )**

For example, the pattern `[^a]` matches any single character (including special characters) except
`a`.

```
Regex     Match
------------------------------------------
[^A-Z]    not an upper case letter
[^Ss]     neither 'S' nor 's'
[^.]      not a period (note that only in this case THIS IS A PERIOD, in other cases . stands for 
                        any character)
```

**Optionality of an expression before a question mark `?`**

```
Regex         Match
------------------------------------------
woodchucks?   woodchuck or woodchucks    --> the letter s is optional
colou?r       color or colour            --> the letter u is optional
```

*Example*:

If you search for `to a?` in the word set below, you are searching for the word 'to' and an optional
letter 'a', so you will find: 

* the first and second `to a` (from "to alter" and "to abolish")
* all the other instances of `to`

> We hold these truths to be self-evident, that all men are created equal, that they are endowed by
  their Creator with certain unalienable Rights, that among these are Life, Liberty and the pursuit
  of Happiness.--That to secure these rights, Governments are instituted among Men, deriving their
  just powers from the consent of the governed, --That whenever any Form of Government becomes
  destructive of these ends, it is the Right of the People to alter or to abolish it, and to
  institute new Government, laying its foundation on such principles and organizing its powers in
  such form, as to them shall seem most likely to effect their Safety and Happiness.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Special characters in regular expressions

```

Regex    Match
------------------------------------------
^        start of line
$        end of line
\b       word boundary
\B       non-word boundary
.        any character
[.]      a period, same as \.

A "word" for the purposes of a regular expression is defined as any sequence of digits, underscores,
or letters (this is based on the definition of "words" in programming languages). 

```

### Word Boundaries

  * `\bthe\b` matches the word '`the`' but not the word '`other`'

  * `\b99\b` will match the string `99` in "There are 99 bottles of beer on the wall" because 99
  follows a space is bounded by two spaces (word boundaries)

  * `\b99\b` will **not** match 99 in "There are 299 bottles of beer on the wall" because 99 follows
    the number 2 which is not a word boundary (digits, underscores, or letters are **not** word
    boundaries)

  * `/\b99\b/` will match `99` in `$99` because 99 follows a dollar sign ($) which is not a digit,
    underscore, or letter and qualifies as a word boundary


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Operator Hierarchy

```

Operator hierarchy, from highest precedence to lowest precedence:

Parenthesis                            ()
Counters aka repetition quantifiers    * + ? {}
Sequences and anchors                  the ^my end$
Disjunction                            |

```

* Counters have a higher precedence than sequences, thus `the*` matches `theeeee` but not
  `thethe`. 

* Sequences have a higher precedence than disjunction, thus `the|any` matches `the` or `any`. But it
  only matches the `any` sequence from the word `thany` (i.e. it doesn't match the whole word
  `thany`) 

————————————
<!-- ≈≈≈≈≈≈ 12 character line (EM Rule —) ≈≈≈≈ -->

Consider the expression `[a-z]*` when matching against the text `once upon a time`. 

Since this expression matches zero or more letters, this expression could match nothing, or just the
first letter o, on, onc, or once. In these cases **regular expressions are set by default to always
match the largest string they can; we say that patterns are greedy**.

To enforce non-greedy matching, we can use another meaning of the `?` qualifier. The operator `*?`
is a "Kleene" star that matches as little text as possible. The operator `+?` is a "Kleene" plus
that matches as little text as possible.

### Repetition Quantifiers

<!-- from .../regexp_summary.md, from R documentation 'regex' -->

* `*` match zero or more times

* `+` match one or more times

* `?` optional match (will be matched at most once)
    - By default, repetition is greedy (the maximal possible number of repeats is used). This can be
      changed to minimal by appending `?` to the quantifier. 

* `{n}` match exactly n times

* `{n,}` match n or more times

* `{n,m}` match at least n times, but not more than m times

* `|` two regular expressions may be joined by `|`; the resulting regular expression matches any
  string matching either subexpression. E.g. `abba|cde` matches either the string `abba` or the
  string `cde`. Note that alternation does not work inside character classes, where `|` has its
  literal meaning.


<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## A Simple Example

Suppose we wanted to write a RE to find cases of the English article '`the`'. A simple
(but incorrect) pattern might be: `/the/`. But one problem is that this pattern will miss the word
when it begins a sentence and hence is capitalized (i.e. `The`). 

This might lead us to the following pattern: `/[tT]he/`. But we will still incorrectly return texts
with `the` embedded in other words (e.g. `other`). 

So we need to specify that we want instances with a word boundary on both sides: `/\b[tT]he\b/`

Suppose we wanted to do this without the use of `/\b/`.[^note_1] We need to specify that we want
instances in which there are no alphabetic letters on either side of '`the`': 
`/[ˆa-zA-Z][tT]he[ˆa-zA-Z]/`

But there is still one more problem with this pattern: it won't find the word '`the`' when it begins
a line. This is because the regular expression `[ˆa-zA-Z]`, which we used to avoid embedded
instances of '`the`', implies that there must be some single(although non-alphabetic) character
before  the '`the`'. 

We can avoid this by specifying that before '`the`' we require either the beginning-of-line or a
non-alphabetic character, and the same at the end of the line: `/(ˆ|[ˆa-zA-Z])[tT]he([ˆa-zA-Z]|$)/`.

The process we just went through was based on fixing two kinds of errors: **false positives**,
strings that we incorrectly matched like 'other' or 'there', and **false negatives**, strings that
we incorrectly missed, like '`The`'. (Addressing these two kinds of errors comes up again and again
in implementing speech and language processing systems.) 

[^note_1]: We might want this since `/\b/` won't treat underscores and numbers as word boundaries;
but we might want to find '`the`' in some context where it might also have underlines or numbers
nearby (`the_` or `the25`). 

<!-- *** continue at page 9 -->
<!-- ~/Downloads/feb_20_2024/Jurafsky_Martin--Speech.pdf -->


## References

* Jurafsky, D., and Martin, J., *Speech and Language Processing: An Introduction to Natural Language
  Processing, Computational Linguistics, and Speech Recognition* (3rd Ed draft) [Link Here][]

[Link Here]: https://web.stanford.edu/~jurafsky/slp3/
# Notes on GitHub Pages and Jekyll themes 

Credit where it's due: I got all this information from the [surfacedetail blog][link_1].(Because the
gh pages documentation certainly didn't have anything related to this, and most stack/forum posts
missed the problem altogether, except for [this one][link_2], which got me closer to the answer.)

## Problem

[These steps][link_3] to change a theme don't really work. The page goes blank.

## Explanation

The default Jekyll theme `minima` has four built-in layouts that are used by different pages of the
blog.

When you switch to one of the other GitHub Pages themes, the new theme might only have the
`default.html` layout. [This is ironic and counter-intuitive. Shouldn't the non-minimal layouts
have more layout files?]

When you switch from `minima` to another layout (e.g. `cayman`) you will get a blank page because
the other layouts are missing.

Examine the source code of the `minima` theme:
`open ~/path_to_site/my_site.github.io/vendor/bundle/ruby/3.2.0/gems/minima-2.5.1/_layouts`.

There are four layout files in the `_layouts` folder:

* `default.html`: the default base layout
* `home.html`: home page layout
* `page.html`: layout for other pages (about, contacts, etc.)
* `post.html`: layout for blog posts

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## Solution

### 1

The first step to sorting the problem out is to copy the missing layout files from the minima
theme into your own `_layouts` folder (in your site folder `~/path_to_site/my_site.github.io/`,
create a folder called `_layouts`). **Do not** copy the file default.html for now, just the missing
files.

Now you can change the theme without triggering error messages and the site will be visible.

Note that the website will fall back to use the `default.html` layout that is baked into in the gem
of the new theme that you selected, so it may or may not have the functionality you require.

**To locate a theme's files on your computer**:

```Bash

cd ~/path_to_site/my_site.github.io/

# Get the location of the gem-based theme files:
bundle info --path minima # instead of "minima" you can enter the name of any theme

# For example, the Minima theme's files might be located in 
# ~/path_to_site/my_site.github.io/vendor/bundle/ruby/3.2.0/gems/minima-2.5.1/

```

### 2

The next step is to use the `default.html` layout file from the theme that you have chosen as the
basis for improving the functionality. I am using `jekyll-theme-tactile`, so copy `default.html`
from the Tactile repo to your `_layouts` folder.

<!-- keeps going ... -->

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈***≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->

[link_1]: https://surfacedetail.blogspot.com/2019/04/github-pages-and-jekyll-themes.html
[link_2]: https://stackoverflow.com/questions/42966262/change-theme-of-my-github-pages-and-pages-are-empty?rq=3
[link_3]: https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-a-theme-to-your-github-pages-site-using-jekyll

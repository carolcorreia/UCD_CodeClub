# 26 07 2018 Section 3.3 to 3.10 
library(ggplot2)

# 3.3 ####
#Mapping an aesthetic to ggplot, color here: 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
#Can also use shape and size, or transparency (alpha) 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
#last point is missing cause there is only 6 shapes in the plot because: 
#1: The shape palette can deal with a maximum of 6 discrete values because more than 6
#becomes difficult to discriminate; you have 7. Consider specifying shapes manually if you
# must have them. 

#Make all your points a specific color - in geom_point, outside aes() : 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 3.3 EXERCISES #####
# 1. Why are the points not blue? 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# Its because the color specification is inside the aes() function 
# I can specify a class to have color here, if I want to specify a color, its outside the bracket

# 2. Which variables in mpg are categorical? Which variables are continuous? 
# (Hint: type ?mpg to read the documentation for the dataset). 
# How can you see this information when you run mpg? 
typeof(colnames(mpg))
?mpg
colnames(mpg)
lapply(mpg, typeof)
lapply(mpg, class)
mpg 
# Because its a tibble you dont need to use head, it will always give you a header and classes of your columns 
# For a data frame you need to use head()
#all integer column types are probably continuous? 

?lapply #returns a list 
#types of vectors 
# integer 1, 2, 3, 
# double 0.22, 0.33, 0.3 - numbers with decimals 
# character - words 
# Whats an atomic vector??? Google it 

# 3. Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables? 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = year))
# color is a range 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = year)) 
# This gave me a range of sizes even though there is only 2 years!!!! 
# huge sizes and small ones, year is a legend 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = year))
# Error: A continuous variable can not be mapped to shape 

# 4. What happens if you map the same variable to multiple aesthetics? 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = class))
# It just does it 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, alpha = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = year, alpha = year))

# 5. What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point) 
?geom_point
# For shapes that have a border (like 21), you can colour the inside and
# outside separately. Use the stroke aesthetic to modify the width of the
# border
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)

# 6. What happens if you map an aesthetic to something other than a variable name, 
# like aes(colour = displ < 5)? 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
# It makes a legend with false and true and splits the colors where display (x axis) is <5 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = year < 2002))
# That one looks very cool 

# 3.5 ####
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# facet_wrap makes multiple plots per class - this will be useful for my HPIs and potentially PCAs? 
?facet_wrap

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)
# This gives one variable levels on top and one on right, and then x y plots 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)
# this one looks odd??? it gives you cyl on top and doesnt create rows and columns, just columns 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(cyl ~ .)
# This one does just rows 

# 3.5 EXERCISES ####
# 1. What happens if you facet on a continuous variable? 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap( ~ year) 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ , nrow = 2) 
mpg 
# It did the first one and the last one.... but the plots look the same? 
unique(mpg$year) 
# 1999 2008 
# There is only 2 years!!!! 
length(unique(mpg$year)) # This tells you how many unique things in a vector 
# So the answer is - if you facet a continuous variable it will give you a lot of answers ? 

# 2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot? 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) 
# This second one says less, apart from the fact that between 4 and r there is nothing

# 3. What plots does the following code make? What does . do? 
# I already found this - . gets rid of columns or rows 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(year ~ .) 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) 

# 4. Take the first faceted plot in this section: 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2) 

# What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages? 
# How might the balance change if you had a larger dataset? 

# Answer --- 
# Faceting splits the data per group instead of giving it a colour. It is easier 
# to distinguish the specific points that are in each group. 
# The colour option would be better in a global approach though - to compare them to each other. 
# I would use faceting only for distinctly separate datasets - for instance, PCA plots at seperate times post infection 

# 5. Read ?facet_wrap. 
# What does nrow do? What does ncol do? 
# What other options control the layout of the individual panels? 
# Ans --- loads (scales, space for size of panels, shrink)
# Why doesn’t facet_grid() have nrow and ncol arguments? 
# Ans -- Because the number of rows and columns are defined by the amount of factors in the variables you choose for the grid. 
?facet_wrap 
?facet_grid

# 6. When using facet_grid() you should usually put the variable 
# with more unique levels in the columns. Why? 

# YEAH, WHY? Fit to page? 

# 3.6. Geometric objects #### 

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy)) 

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv)) 

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) 

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  ) 

# Display multiple geoms on one plot 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy)) 

# This is better, you don't forget to make the geoms exactly the same if you set mappings directly to ggplot 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# you can display different aesthetics in different layers 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth() 

# Different data used for two layers - ERROR!!! 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) 
# comparison (1) is possible only for atomic and list types 
# In data.matrix(data) : NAs introduced by coercion 

typeof(mpg$class)
mpg 

# 3.6. EXERCISES ##### 
# 1. What geom would you use to draw a line chart? A boxplot? A histogram? An area chart? 
?geom_line  # (can be used with geom_point)
?geom_boxplot
?geom_histogram
?geom_area 

# 2. 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE) # here no standard error, thats what se is 

# 3. show.legend = FALSE Removes legend 
# 4. se shows standard error 

# 5. No 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# 6. Recreate the R code necessary to generate the following graphs. 
# Graphs go : top left right, next row, left right etc 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 4) + 
  geom_smooth(size = 2, se = FALSE) 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = drv)) + 
  geom_point(size = 4) + 
  geom_smooth(size = 2, se = FALSE) 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(size = 4) + 
  geom_smooth(size = 2, se = FALSE) 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes (color = drv) , size = 4) + 
  geom_smooth(size = 2, se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes (color = drv) , size = 4) + 
  geom_smooth(mapping = aes (linetype = drv), size = 2, se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(colour = "white", fill = "white", size = 4, stroke = 4) + 
  geom_point(mapping = aes (color = drv) , size = 4) 
# I didnt know how to make them all have white outline so I overlayed coloured points on white points 

?geom_smooth
?geom_point 

# 3.7 Statistical transformations - 7/08/2018 #####
library(ggplot2)

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
?geom_bar 

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut)) # same plot as the one above 

library(tidyverse)
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
) 
#tribble is a function from tidyverse 

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity") 
# change the stat of geom_bar() from count (the default) to identity 

#bar chart of proportion, not count 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1)) 

#summarize y variables for each x variable 
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# 3.7. EXERCISES ###### 
# 1. 
?stat_summary()
ggplot(data = diamonds) + 
  geom_pointrange(mapping = aes(x = cut, y = depth), stat = "summary", 
                  fun.ymin = min,
                  fun.ymax = max,
                  fun.y = median
                  ) 
# defauly geom is pointrange 
# in pointrange though, default stat is identity - need to change to summary 

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth)
  ) 

ggplot(data = diamonds) + 
  geom_boxplot(
    mapping = aes(x = cut, y = depth),
  ) 

ggplot(data = diamonds) + 
  geom_pointrange(
    mapping = aes(x = cut, y = depth), ymin = min(diamonds$depth), ymax = max(diamonds$depth)
  )
#not exactly the same - this plots the overall min and max, not the one in each cut 

ggplot(data = diamonds) + 
  geom_count(
    mapping = aes(x = cut, y = depth)
  ) 

# 2. 
ggplot(data = diamonds) + 
  geom_col(
    mapping = aes(x = cut, y = depth)
  ) 
ggplot(data = diamonds) + 
  geom_point(
    mapping = aes(x = cut, y = depth)
  ) 
?geom_col 
#represents values in the data (but which values?) 

diamonds 

# 3. 
# List of geoms and stats available here: 
#  https://ggplot2.tidyverse.org/reference/#section-layer-geoms 
# Most stats are called the same as the geoms. 

# 4. 
?stat_smooth 
# It shows a trendline, and you can apply a non standard geom to it 

#5. Whats wrong with these? Why do you need to set group = 1 ? 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop..))
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..)) 
# ????? 
# it groups the bar chart by color? and there must be the same proportion in each color? 
 
nrow(subset(diamonds, color == "E")) # 9797
nrow(subset(diamonds, color == "F")) # 9542
nrow(diamonds) #53940 
53940/9797 #5.505767
53940/9542 #5.652903 

# 3.8. Position adjustments ##### 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut)) # colour is the outline 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut)) 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill") 
# this changes the graph to a proportion one 
# position "identity" will show the variable where it falls on the graph - 
# not useful for bar charts 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge") 
#overlapping objects beside one another 
#? can I do this with geom_point? I did it previously by geom_jitter 
# yes, position = "jitter"
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter") 
# this adds some random noise to points that are the same! 

# 3.8 EXERCISES ##### 
#1. 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point() 
# better 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter() 

#2. 
?geom_jitter() 
#width and height control the amount of vertical and horizontal jitter 
ggplot(mpg, aes(cyl, hwy)) + geom_jitter()
ggplot(mpg, aes(cyl, hwy)) + geom_jitter(width = 0.25) #makes the jitter smaller 

#3. 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count() 
#geom count is good as well, it shows density of the dots there. jitter looks nicer? 
# also makes it easier to see, geom_count you cannot be sure what the amount of points actually is 

#4. What’s the default position adjustment for geom_boxplot()? Create a visualisation of the mpg dataset that demonstrates it.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = class, color = class)) + 
  geom_boxplot(show.legend = TRUE) 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group = class, color = class)) + 
  geom_boxplot(show.legend = TRUE, position = "dodge")  
# in this second one boxplots overlap, but it sits where the actual dspl is
?geom_boxplot 
mpg
# default position is "dodge2" 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge2") 
# in barplot dodge and dodge2 make no difference 

# 3.9 Coordinate systems ##### 

# Flip an axis 
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip() 

# Error: Package `maps` required for `map_data`. 
nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap() 

# Polar coordinates 

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar() # does it show proportion? 


# 3.9 EXERCISES ###### 

#1. Turn a stacked bar chart into a pie chart using coord_polar() 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) + 
  coord_polar()

#2. 
?labs() # this is for labels 

#3. 
?coord_map 
?coord_quickmap # quick projection, works best for smaller areas closer to the equator. 

#4. 
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() + #this adds a trendline? 
  coord_fixed() # this keeps the plot a square? 
?geom_abline #  add reference lines 

p <- ggplot(mtcars, aes(wt, mpg)) + geom_point() 
p + geom_vline(xintercept = 5)
p + geom_vline(xintercept = 1:5)
p + geom_hline(yintercept = 20)

p + geom_abline() # Can't see it - outside the range of the data
p + geom_abline(intercept = 20) 

# Calculate slope and intercept of line of best fit
coef(lm(mpg ~ wt, data = mtcars))
p + geom_abline(intercept = 37, slope = -5)
# But this is easier to do with geom_smooth:
p + geom_smooth(method = "lm", se = FALSE) 


# 3.10 . The grammar of plot code ###### 

# standard code 
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION> 



# Carol's idea - make our coloured plots, use themes ##### 
# ggtheme in google 
# https://ggplot2.tidyverse.org/reference/ggtheme.html 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) + theme_bw()
# Out of the ones I saw this is the nicest one

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) + theme_light()

library(RColorBrewer)
?RColorBrewer
display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE, 
                   colorblindFriendly=FALSE) 
brewer.pal.info

mypalette <- brewer.pal(7, "Spectral") # this didn't work 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class), color = mypalette) + 
  facet_grid(drv ~ cyl) + theme_bw() 
# Error: Aesthetics must be either length 1 or the same as the data (234): colour
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

sp <- ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) + 
  facet_grid(drv ~ cyl) + theme_bw() 
# Pretty plot, can use to separate my strains by colour in PCAs 
sp 
sp + scale_color_brewer(palette="Paired") # this one is ok 
sp + scale_color_brewer(palette="Dark2") # this is good, vivid colors, easy to distinguish 

# Types of data: 
# Matrix is only numbers, no text 
# Data frame has text 


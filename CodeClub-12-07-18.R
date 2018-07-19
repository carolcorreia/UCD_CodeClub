# CodeClub meeting 12th July 2018
# Book: http://r4ds.had.co.nz
# Sections covered: 1 to 3.2

# Anything followed by a hashtag is a comment, therefore, it won't
# be evaluated by R. Get into the habit of commenting
# what your code does.

# Original examples from the book:
library(ggplot2) # Load package

ggplot2::mpg # Load mpg data set
ggplot(data = mpg) + # Call ggplot2 package
  geom_point(mapping = aes(x = displ, y = hwy)) # Plot points

ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))


# Modified to generate high resolution pdf and custom font (good for
# publications):
library(ggplot2)
library(Cairo) # Cairo helps generates pdfs, pngs, and other image formats

mpg_plot <- ggplot(data = mpg) + # The <- allows us to store the plot in the 'mpg_plot' variable
  geom_point(mapping = aes(x = displ, y = hwy)) +
  theme(text = element_text(size = 14, family = "Calibri")) # Specify font size and family

ggsave("mpg_plot.pdf", # Name of the file to be saved
       plot      = mpg_plot, # The variable where you stored the plot
       device    = cairo_pdf, # We use Cairo here
       path      = "/Users/ccorreia/Documents/", # Folder where the plot will be saved
       limitsize = FALSE,
       dpi       = 300, # Dots per inch, 300 is agood resolution for printing
       height    = 10,
       width     = 8,
       units     = "in") # Units in inches

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

# LaTeX configurations
mpl.rcParams['text.usetex'] = True
mpl.rcParams['font.family'] = 'serif'
mpl.rcParams['font.sans-serif'] = 'cm'
mpl.rcParams['text.latex.unicode'] = True

mpl.rcParams["font.size"] = 11
mpl.rcParams["axes.labelsize"] = 11
mpl.rcParams["legend.fontsize"] = 11

mpl.rcParams["xtick.labelsize"] = 11
mpl.rcParams["ytick.labelsize"] = 11

mpl.rcParams["xtick.direction"] = 'in'
mpl.rcParams["ytick.direction"] = 'in'

mpl.rcParams["axes.linewidth"] = 0.5
mpl.rcParams["lines.linewidth"] = 0.5
mpl.rcParams["lines.markeredgewidth"] = 0
mpl.rcParams["legend.fancybox"] = 'False'
mpl.rcParams["ytick.major.width"] = 0.5
mpl.rcParams["xtick.major.width"] = 0.5

mpl.rcParams["legend.edgecolor"] = 'black'
mpl.rcParams["legend.fancybox"] = 'False'

mpl.rcParams['text.latex.preamble'] = [
    '\\usepackage{siunitx}'
]

# define constants
K = 1.760
L = 3.370

# define domain
x = np.linspace(K, L, 100)
y = np.linspace(0, 4, 100)
x,y = np.meshgrid(x, y)

# plot the function
z = np.maximum(x, y)
plt.pcolor(x, y, z, cmap='rainbow')

# plot y=x
d = np.linspace(0, K+L, 10)
plt.plot(d, d, '--', color='black')

# configure axes
plt.axis('scaled')
plt.axis([0, K+L, y.min(), y.max()])

# add the color bar on the right
#plt.colorbar()

w,h = plt.gcf().get_size_inches()
plt.gcf().set_size_inches(0.7*w, 0.7*h)

plt.savefig('figure/graph_max.pgf', bbox_inche='tight', transparent=False)

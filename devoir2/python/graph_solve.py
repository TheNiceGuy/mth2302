import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy.special import factorial

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

@np.vectorize
def func(m):
    return (factorial(m)*np.exp(m))/(m**(m+1))

# define domain
m = np.linspace(20,30,100)

# compute curves
y1 = func(m)
y2 = m-m+0.710*0.715

# plot curves
c, = plt.plot(m, y1, color='black')
d, = plt.plot(m, y2, "--",color='black')

# draw intersection
idx = np.argwhere(np.diff(np.sign(y2 - y1)) != 0).reshape(-1) + 0
plt.plot(m[idx[0]], y1[idx[0]], 'o', color='black')
plt.plot([m[idx[0]],m[idx[0]]], [0,y1[idx[0]]], '-.', color='black')
print(m[idx[0]])

# set tick frequency for each interger
plt.xticks(np.arange(min(m), max(m)+1, 1.0))

# configure axes
plt.gca().set_xlabel('$m$')
plt.gca().set_xlim(20, 30)
plt.gca().set_ylim(0.4,0.6)
plt.legend([c,d],['$\\displaystyle\\frac{m!}{m^{m+1}}\mathrm{e}^m$','$A\cdot B$'])

w,h = plt.gcf().get_size_inches()
plt.gcf().set_size_inches(0.7*w,0.7*h)

plt.savefig('figure/graph_solve.pgf',bbox_inches='tight',transparent=True)

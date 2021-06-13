# -*- coding: utf-8 -*-

project = u'shellwrap'
copyright = u'2016, Vladimir Roncevic <elektron.ronca@gmail.com>'
author = u'Vladimir Roncevic <elektron.ronca@gmail.com>'
version = u'1.0'
release = u'https://github.com/vroncevic/shellwrap/releases'
extensions = []
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
language = None
exclude_patterns = []
pygments_style = None
html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
htmlhelp_basename = 'shellwrapdoc'
latex_elements = {}
latex_documents = [(
    master_doc, 'shellwrap.tex', u'shellwrap Documentation',
    u'Vladimir Roncevic \\textless{}elektron.ronca@gmail.com\\textgreater{}',
    'manual'
)]
man_pages = [(
    master_doc, 'shellwrap', u'shellwrap Documentation', [author], 1
)]
texinfo_documents = [(
    master_doc, 'shellwrap', u'shellwrap Documentation', author, 'shellwrap',
    'One line description of project.', 'Miscellaneous'
)]
epub_title = project
epub_exclude_files = ['search.html']

.. trial_django documentation master file, created by
   sphinx-quickstart on Sat Dec 14 12:07:58 2024.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to trial_django's documentation!
========================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

  # シーケンス図サンプル
.. uml::
   :scale: 50 %
   :align: center

   @startuml

      actor User

      User -> Form : Input user information
      activate Form
      Form -> Database : Register user information
      activate Database
      Form <- Database : Inform success
      deactivate Database
      User <- Form : Show success message
      deactivate Form

   @enduml


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

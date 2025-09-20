{===============================================================================}
{                          Free Delta Editor                                    }
{         A software package for building taxonomic databases                   }
{                   (c) 2000-2025 by Mauro J. Cavalcanti                        }
{                         <maurobio@gmail.com>                                  }
{                                                                               }
{   This program is free software: you can redistribute it and/or modify        }
{   it under the terms of the GNU General Public License as published by        }
{   the Free Software Foundation, either version 3 of the License, or           }
{   (at your option) any later version.                                         }
{                                                                               }
{   This program is distributed in the hope that it will be useful,             }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of              }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               }
{   GNU General Public License for more details.                                }
{                                                                               }
{   You should have received a copy of the GNU General Public License           }
{   along with this program. If not, see <http://www.gnu.org/licenses/>.        }
{                                                                               }
{   Requirements:                                                               }
{     Lazarus 3.0+ (www.lazarus.freepascal.org)                                 }
{     Free Pascal 3.0+ (www.freepascal.org)                                     }
{     HistoryFiles 1.3+ (wiki.freepascal.org/HistoryFiles)                      }
{     HtmlViewer 10.2+ (wiki.freepascal.org/THtmlPort)                          }
{     RichMemo 1.0+ (wiki.freepascal.org/RichMemo)                              }
{     SynFacilSyn 1.21+ (github.com/t-edson/SynFacilSyn)                        }
{                                                                               }
{  REVISION HISTORY:                                                            }
{  Version 1.00, 2nd Feb 2020     - Initial release;                            }
{  Version 1.01, 4th Feb 2020     - Fixed an issue with the creation of the     }
{                                   program configuration file in the           }
{                                   installation directory. This file has       }
{                                   been moved to an appropriate directory      }
{                                   in the user's configuration folder.         }
{  Version 1.02, 9th Feb 2020     - Fixed the folder access problems still      }
{                                   appearing in previous versions.             }
{  Version 1.03, 10th Feb 2020    - Added a dialog box for manual selection     }
{                                   of the R installation directory, in case    }
{                                   it is not found automatically by the        }
{                                   program.                                    }
{                                 - Added a folder to store vocabularies to     }
{                                   produce natural language descriptions in    }
{                                   different idioms.                           }
{  Version 1.04, 11th Feb 2020    - Fixed a bug which prevented the DELTA       }
{                                   programs from being correctly found in      }
{                                   the application folder.                     }
{  Version 1.05, 19th Feb 2020    - Removed code for creating file              }
{                                   association for the extension '.dtz',       }
{                                   which is now executed by the installation   }
{                                   program (MS-Windows only).                  }
{  Version 1.06, 24th Feb 2020    - Changed the default cursor for a waiting    }
{                                   one when loading files.                     }
{                                 - Fixed the display of dataset information    }
{                                   in the status bar when a file is closed.    }
{                                 - Fixed ambiguous variable names in DELTA     }
{                                   writing routines in the Delta Library,      }
{                                   which could prevent to saving the SPECS     }
{                                   file correctly.                             }
{  Version 1.07, 26th Feb 2020    - Fixed a bug which raised errors in R when   }
{                                   reading data files with blanks in the       }
{                                   item names; blanks in item names are now    }
{                                   replaced by underscores.                    }
{  Version 1.08, 18th Apr 2020    - Fixed a bug which prevented the execution   }
{                                   of DELTA IntKey program when not in path.   }
{                                   (MS-Windows only).                          }
{                                 - Fixed a big which prevented the correct     }
{                                   creation of the directives file for         }
{                                   building of conventional dichotomous keys.  }
{                                 - Fixed a big which prevented the correct     }
{                                   saving of the items and specs files.        }
{                                 - Fixed a bug which prevented the editing     }
{                                   of text characters before saving a file.    }
{                                 - Added missing manipulation events to the    }
{                                   save and search toolbar buttons.            }
{                                 - Added a check for the existence of the      }
{                                   output files for descriptions, keys, and    }
{                                   data matrices from previous runs and        }
{                                   deleting them of they exist.                }
{                                 - Added dragging and dropping of data files   }
{                                   on the program main form.                   }
{  Version 1.09, 29th Apr 2020    - Fixed a bug which prevented the inclusion   }
{                                   of new characters without adding an item    }
{                                   first.                                      }
{                                 - Fixed a bug which raised an error message   }
{                                   when a data file was double-clicked in      }
{                                   the Windows Explorer (MS-Windows only),     }
{                                 - Changed the default extension of keys,      }
{                                   descriptions, and report output files to    }
{                                   '.txt' for better integration with the      }
{                                   operating system.                           }
{                                 - Removed the Save button from the view       }
{                                   results form.                               }
{                                 - Added missing copy event for images in      }
{                                   the view results form.                      }
{                                 - Added output and display of descriptions    }
{                                   and keys in HTML format.                    }
{                                 - Added printing of characters and items.     }
{  Version 1.10, 4th May, 2020    - Fixed the placement of some dialog boxes    }
{                                   on small screen resolutions.                }
{                                 - Added support for exporting data files in   }
{                                   XDELTA XML format.                          }
{  Version 1.11, 18th May, 2020   - Added support to inclusion of item and      }
{                                   character images, using the INTIMATE        }
{                                   program (MS-Windows only).                  }
{                                 - Added support to dependent characters.      }
{                                 - Added reordering of items and characters.   }
{                                 - Added inserting of items and characters.    }
{                                 - Updated the Portuguese translation.         }
{  Version 1.12, 30th May, 2020   - Added option for cloning (duplicating) an   }
{                                   item description.                           }
{                                 - Added option for merging another list of    }
{                                   characters with the current one.            }
{                                 - Changed the design of forms to better       }
{                                   accommodate translated text and smaller     }
{                                   screen resolutions.                         }
{                                 - Added French translation and vocabulary.    }
{                                 - Updated the Portuguese translation.         }
{  Version 1.50, 15th Jun, 2020   - Added a form for converting quantitative    }
{                                   characters into qualitative and generate    }
{                                   key states automatically.                   }
{                                 - Added new color icons to distinguish        }
{                                   between unordered/ordered multistate and    }
{                                   integer/real numeric characters.            }
{                                 - Changed the option for merging character    }
{                                   lists to allow the merge procedure to be    }
{                                   performed without a specifications file,    }
{                                   by treating all merged characters as        }
{                                   qualitative multistate.                     }
{                                 - Updated the Portuguese and French           }
{                                   translations.                               }
{  Version 1.60, 9th Jul, 2020    - Added log output of DELTA programs errors.  }
{                                 - Added the creation of backup files before   }
{                                   saving data files.                          }
{                                 - Fixed a bug which prevented the correct     }
{                                   display of character dependencies in the    }
{                                   character tree.                             }
{                                 - Fixed a bug which prevented the output of   }
{                                   natural language descriptions when the      }
{                                   translating implicit values.                }
{                                 - Fixed a bug which raised an error when a    }
{                                   character type was changed.                 }
{                                 - Fixed several bugs in the character         }
{                                   editor that prevented adding or changing    }
{                                   character names and states.                 }
{                                 - Changed the output of the CHARS file to     }
{                                   omit RTF typesetting marks.                 }
{  Version 1.70, 23th Jun, 2020   - Added a label for displaying the control    }
{                                   attribute of a dependent character in the   }
{                                   item descriptions form.                     }
{                                 - Added a button in the item descriptions     }
{                                   form to allow going to a given character    }
{                                   by its number.                              }
{                                 - Added saving of the current view to the     }
{                                   program configuration file so it can be     }
{                                   restored each time the program is run.      }
{                                 - Fixed a bug which raised an error when a    }
{                                   text or numeric character was changed to    }
{                                   multistate.                                 }
{                                 - Fixed a bug which sometimes prevented the   }
{                                   edition of multistate characters and        }
{                                   scoring of items.                           }
{                                 - Fixed a bug which prevented the correct     }
{                                   saving of multistate characters.            }
{  Version 1.80, 3rd Aug, 2020    - Added an option to the Matrix menu for      }
{                                   calling the phylogenetic analysis program   }
{                                   TNT from the Matrix menu.                   }
{                                 - Fixed a bug which prevented the correct     }
{                                   finding of R executable directory.          }
{  Version 1.90, 29th Aug, 2020   - Added a call to DELTA IntKey help file      }
{                                   according to the program selected           }
{                                   language.                                   }
{                                 -´Added a Find Next option to the Search      }
{                                   menu to allow incremental searches in the   }
{                                   items and characters lists.                 }
{                                 - Added saving of directives files in the     }
{                                   data files, along with the items,           }
{                                   characters, and specifications.             }
{                                 -´Changed the Search dialog to allow          }
{                                   definition of search parameters.            }
{                                 - Fixed a bug which prevented the reading     }
{                                   of the character notes when loading a       }
{                                   dataset.                                    }
{                                 - Fixed a bug which prevented the use of      }
{                                   French vocabulary when generating natural   }
{                                   language descriptions in French language.   }
{ Version 1.95, 30th Sep, 2020    - Added check of characters and items when    }
{                                   importing DELTA files and merging           }
{                                   character lists.                            }
{                                 - Fixed a bug which prevented the correct     }
{                                   ordering of characters when merging         }
{                                   character lists.                            }
{                                 - Fixed a bug which prevented the correct     }
{                                   insertion of characters in the character    }
{                                   tree.                                       }
{ Version 1.96, 15th Oct, 2020    - Fixed a bug which prevented the correct     }
{                                   display of natural-language descriptions    }
{                                   and dichotomous keys.                       }
{ Version 1.97, 3rd Nov, 2020     - Fixed a bug which caused an error message   }
{                                   to be incorrectly issued when importing     }
{                                   data files.                                 }
{ Version 1.98, 22th Nov, 2020    - Added a check for opening/closing of        }
{                                   brackets in characters and states.          }
{                                 - Changed checking for the number of states   }
{                                   when entering multistate characters from    }
{                                   0 to 2.                                     }
{                                 - Fixed a bug which prevented the correct     }
{                                   merging of character lists.                 }
{                                 - Fixed a bug which prevented the correct     }
{                                   display of implicit values when editing     }
{                                   characters.                                 }
{                                 - Fixed a bug which caused some dialogs to    }
{                                   appear as non-modal.                        }
{ Version 1.99, 30th Nov, 2020    - Added an option to go to a given item or    }
{                                   character by its number.                    }
{                                 - Changed the shortcut Ctrl+G key from        }
{                                   the Edit Images option to the newly added   }
{                                   Go To Line option.                          }
{ Version 2.00, 21st Dec, 2020    - Added an indicator of the editing status    }
{                                   of a file in the title bar.                 }
{                                 - Removed the check for opening/closing of    }
{                                   brackets in characters and states.          }
{                                 - Fixed a bug which caused only the first     }
{                                   item to be selected for description.        }
{                                 - Fixed a bug which caused the number of      }
{                                   states to be incorrectly written to the     }
{                                   SPECS file.                                 }
{                                 - Fixed a bug which prevented the dependent   }
{                                   characters line to be correctly wrapped     }
{                                   in the SPECS file.                          }
{                                 - Updated the Portuguese and French           }
{                                   translations.                               }
{ Version 2.10, 12th Jan, 2021    - Fixed a bug which prevented the dependent   }
{                                   characters directive to be correctly        }
{                                   written to the SPECS file.                  }
{                                 - Fixed a bug which caused the ITEMS file     }
{                                   be incorrectly written.                     }
{                                 - Fixed a bug which prevented item comments   }
{                                   to be saved to the ITEMS file.              }
{                                 - Fixed a bug which prevented the editing     }
{                                   status indicator of being updated after     }
{                                   saving a file.                              }
{                                 - Fixed a bug which prevented a new file      }
{                                   from being found by CONFOR after importing  }
{                                   a DELTA dataset.                            }
{                                 - Fixed a bug which prevented the character   }
{                                   tree of being updated when a new item was   }
{                                   was added or inserted.                      }
{ Version 2.20, 8th Feb, 2021     - Fixed a bug which prevented the dependent   }
{                                   character states of being properly checked  }
{                                   in the character tree.                      }
{ Version 2.30, 11th Feb, 2021    - Added saving of the current state of the    }
{                                   character tree (collapsed/expanded) to the  }
{                                   program configuration file so it can be     }
{                                   restored between sessions.                  }
{                                 - Added support for multiple dependent        }
{                                   characters.                                 }
{                                 - Added new icon for displaying implicit      }
{                                   values.                                     }
{                                 - Fixed a bug which prevented the display of  }
{                                   the character tree when a new character     }
{                                   was inserted.                               }
{ Version 2.40, 23th Feb, 2021    - Fixed a bug which caused an error when      }
{                                   writing the dependent characters directive  }
{                                   to the SPECS file.                          }
{ Version 2.50, 28th Feb, 2021    - Added support for entering and editing      }
{                                   directly using the attribute editor.        }
{                                 - Added full support for multiple dependent   }
{                                   characters.                                 }
{                                 - Changed the shortcut keys for the Clone     }
{                                   menu option to Ctrl+L to avoid conflict     }
{                                   with the standard Ctrl+C combination.       }
{                                 - Changed the DELTA reading routines for      }
{                                   removing RTF typesetting marks from input   }
{                                   DELTA data files.                           }
{ Version 2.51, 19 Mar, 2021      - Changed the cursor to waiting mode when     }
{                                   collapsing/expanding the character tree.    }
{                                 - Updated the user's guide.                   }
{ Version 2.52, 29 Apr, 2021      - Added an error message if the key output    }
{                                   cannot be created.                          }
{                                 - Fixed a bug which prevented the correct     }
{                                   handling of the *ITEM SUBHEADINGS           }
{                                   directive.                                  }
{                                 - Fixed a bug which prevented directives      }
{                                   from being read from the KEY directives     }
{                                   file.                                       }
{                                 - Fixed a bug which caused the key output     }
{                                   file not being displayed when the key is    }
{                                   incomplete.                                 }
{ Version 2.53, 19 May, 2021      - Added support for long lines in the CONFOR, }
{                                   KEY, and DIST directives files.             }
{                                 - Removed the need for setting an environment }
{                                   variable for IntKey. (MS-Windows only)      }
{                                 - Fixed a bug which prevented the saving of   }
{                                   excluded characters in the TOKEY directives }
{                                   file.                                       }
{                                 - Fixed a bug which prevented the correct     }
{                                   adding and editing of characters.           }
{ Version 2.60, 3 Jun, 2021       - Added support for reading the value of the  }
{                                   DATA BUFFER SIZE directive from the SPECS   }
{                                   file and retaining it.                      }
{                                 - Changed the TOKEY form to allow including   }
{                                   items/characters instead of excluding them. }
{                                 - Changed the DELTA parsing routines for not  }
{                                   omitting RTF typesetting marks from the     }
{                                   data, if any.                               }
{                                 - Changed the IntKey initialization file to   }
{                                   'intkey.ink'. (MS-Windows only)             }
{                                 - Fixed a bug in the DELTA parsing routines   }
{                                   which caused character states containing    }
{                                   internal slashes ('/') to be incorrectly    }
{                                   read.                                       }
{                                 - Fixed a bug in the DELTA parsing routines   }
{                                   which caused text characters to be          }
{                                   incorrectly always written between angle    }
{                                   brackets.                                   }
{                                 - Fixed a bug in the DELTA parsing routines   }
{                                   which caused item descriptions containing   }
{                                   dashes ('-') to be broken by an end-of-line }
{                                   after the '-'.                              }
{                                 - Fixed a bug in the DELTA parsing routines   }
{                                   which caused the line endings in the CNOTES }
{                                   files to be written as just 'LF' instead of }
{                                   'CR/LF'.                                    }
{                                 - Fixed a bug which caused the SPECS file not }
{                                   being found after saving a datafile.        }
{                                 - Updated the user's guide.                   }
{ Version 2.61, 8 Jun, 2021       - Added an option to the Help menu to display }
{                                   the user's guide by pressing F1 using the   }
{                                   system default PDF viewer.                  }
{                                 - Fixed a bug which caused the key output     }
{                                   file not being displayed when the key is    }
{                                   not generated.                              }
{                                 - Updated the user's guide.                   }
{ Version 2.62, 15 Jun, 2021      - Fixed a bug which caused directives files   }
{                                   TONAT, TOKEY, etc. to be incompletely read  }
{                                   when the lists of included/excluded         }
{                                   extended for more than one line.            }
{ Version 2.70, 22 Jun, 2021      - Added a form for configuring the CONFOR     }
{                                   directives for parsimony analysis.          }
{                                 - Removed the Nexus and TNT options from the  }
{                                   Export menu.                                }
{                                 - Removed the Nexus option from the Import    }
{                                   menu.                                       }
{                                 - Fixed a bug which prevented generated key   }
{                                   states from being placed in the appropriate }
{                                   fields in the conventional key and matrices }
{                                   for parsimony analysis forms.               }
{                                 - Updated the user's guide.                   }
{ Version 2.71, 7 Jul, 2021       - Added a message to inform the file name and }
{                                   directory where the data matrix for         }
{                                   parsimony analysis is saved.                }
{ Version 2.80, 23 Jul, 2021      - Added support for PAUP parsimony program.   }
{                                 - Added a 'script editor' with DELTA syntax   }
{                                   highlighting for editing/running            }
{                                   CONFOR/KEY/DIST directives files.           }
{                                 - Updated the user's guide.                   }
{ Version 2.81, 3 Aug, 2021       - Fixed a bug which prevented the R program   }
{                                   to be correctly called under GNU/Linux.     }
{                                 - Changed the default value of the            }
{                                   *TRANSLATE IMPLICIT VALUES to false in the  }
{                                   translate into natural language form.       }
{ Version 2.82, 11 Aug, 2021      - Fixed a bug which caused implicit values to }
{                                   be incorrectly written to the SPECS file.   }
{                                 - Added a button to the About form to allow   }
{                                   donations to the Free Delta Project via     }
{                                   PayPal.                                     }
{ Version 2.83, 30 Aug, 2021      - Added an option for exporting the entire    }
{                                   data matrix to a tab-delimited text file.   }
{                                 - Updated the user's guide.                   }
{ Version 2.84, 15 Out, 2021      - Fixed a bug which caused a console screen   }
{                                   to be displayed when running R scripts      }
{                                   (MS-Windows only).                          }
{                                 - Fixed a bug which caused character states   }
{                                   lines containing carriage returns to be     }
{                                   incorrectly read as separate states.        }
{                                 - Fixed a bug which prevented the correct     }
{                                   generation of natural-language descriptions }
{                                   in HTML format.                             }
{                                 - Changed the mouse cursor to waiting mode    }
{                                   when running R scripts.                     }
{                                 - Updated Portuguese and French translations. }
{ Version 2.85, 12 Nov, 2021      - Changed the way the R software for          }
{                                   statistical computing and graphics is found }
{                                   in the current OS to be fully automatic.    }
{ Version 2.90, 17 Jan, 2022      - Added support to RTF in natural-language    }
{                                   descriptions.                               }
{ Version 2.91, 27 Mar, 2022      - Fixed a bug which caused all characters in  }
{                                   the character tree to appear unmarked when  }
{                                   the Character Edit dialog was closed by     }
{                                   pressing the OK button.                     }
{ Version 2.92, 16 Nov, 2022      - Fixed a bug which prevented some forms and  }
{                                   dialogs not being correctly translated.     }
{                                 - Added minor corrections to the user's guide.}
{ Version 2.93, 5 Dec, 2022       - Added a form for editing IntKey directives. }
{                                 - Fixed a bug which caused CIMAGES directive  }
{                                   to be incorrectly generated.                }
{                                 - Updated the user's guide.                   }
{ Version 2.94, 15 Dec, 2022      - Fixed a problem with executing IntKey when  }
{                                   its path was not correctly set.             }
{                                 - Fixed translated text not being displayed   }
{                                   in the TOINT editing form.                  }
{ Version 2.95, 20 Dec, 2022      - Fixed a bug which caused the incorrect      }
{                                   generation of the TOINT directives file.    }
{                                 - Fixed a problem with executing Intimate     }
{                                   when its path was not correctly set.        }
{ Version 2.96, 19 Feb, 2023      - Added the CIMAGES and TIMAGES files to the  }
{                                   list of saved files in a dataset.           }
{                                 - Added a new field to the TOINT form to set  }
{                                   the image path directive.                   }
{                                 - Fixed a bug with writing lines too long for }
{                                   the *DEPENDENT CHARACTERS directive.        }
{ Version 2.97, 15 Mar, 2023      - Changed the default extension of exported   }
{                                   tab-delimited text files to .txt.           }
{                                 - Added an option to export the data matrix   }
{                                   Excel 97-2003 (.xls) format.                }
{ Version 2.98, 11 May, 2023      - Changed the viewer form to allow it to be   }
{                                   maximized upon displaying.                  }
{                                 - Fixed a bug which sometimes caused the      }
{                                   DELTA programs to raise errors when a data  }
{                                   file was opened just after another.         }
{                                 - Updated Portuguese and French translations. }
{ Version 2.99, 1 Nov, 2023       - Added Spanish translation and vocabulary.   }
{                                 - Changed the behavior of the attribute editor}
{                                   to accept the ENTER key to finish editing.  }
{ Version 3.00, 21 Nov, 2023      - Bug fixes and minor improvements to the     }
{                                   cluster and ordination R scripts.           }
{                                 - Added check marks to the included/excluded  }
{                                   characters and/or items in the popup        }
{                                   selection lists in the CONFOR directives    }
{                                   forms.                                      }
{ Version 3.10, 29 Nov, 2023      - Added support for expanding ranges of items }
{                                   and character numbers in the CONFOR         }
{                                   directives forms.                           }
{                                 - Fixed a bug which caused the selection lists}
{                                   of items and characters to appear duplicated}
{                                   in the CONFOR directive forms.              }
{ Version 3.20, 6 Dec, 2023       - Added support for compressing ranges of     }
{                                   items and character numbers in the CONFOR   }
{                                   directives forms.                           }
{                                 - Added data checks when importing DELTA      }
{                                   CHARS, ITEMS, and SPECS files.              }
{                                 - Changed call to the IntKey program to the   }
{                                   version provided with the Open DELTA suite  }
{                                 - Removed the Images option from the Edit menu}
{ Version 3.30, 20 Dec, 2023      - Added automatic removal of inner comments   }
{                                   when reading and/or importing DELTA ITEMS   }
{                                   files.                                      }
{                                 - Added a check to prevent the input of       }
{                                   unsupported inner comments in the attribute }
{                                   editor.                                     }
{                                 - Added a check to detect missing opening     }
{                                   or closing angle brackets in the attribute  }
{                                   editor.                                     }
{                                 - Changed the Save toolbat button to appear   }
{                                   enabled when a dataset is modified, and     }
{                                   disabled when a dataset is saved.           }
{                                 - Fixed a bug with sometimes caused the symbol}
{                                   '/' to be wrongly interpreted as a delimiter}
{                                   when appearing in the middle of names of    }
{                                   character states.                           }
{                                 - Fixed a bug which prevented the correct     }
{                                   export of the CNOTES file when exporting    }
{                                   data in DELTA format.                       }
{                                 - Fixed a bug which caused the value of the   }
{                                   *DATA BUFFER SIZE directive not being       }
{                                   retained when exporting data in DELTA format}
{                                 - Fixed a bug which caused the directive      }
{                                   *OMIT TYPESETTING MARKS not being written to}
{                                   the TONAT output file.                      }
{                                 - Fixed a bug which sometimes caused an error }
{                                   when deleting character states.             }
{ Version 3.40, 14 Dec, 2024      - Added support for exporting data files in   }
{                                   SLIKS format.                               }
{                                 - Changed the routine which gets the dataset  }
{                                   name from a directives file to retrieve the }
{                                   first title when there is more than one     }
{                                   *SHOW directive in the file.                }
{ Version 4.06, 23 Apr, 2025      - Changed interface to replace the character  }
{                                   tree with a simple list view.               }
{                                 - Removed from main screen the edit box for   }
{                                   editing item descriptions.                  }
{                                 - Restored the Item Descriptions dialog box   }
{                                   from previous version 2.4.0                 }
{                                 - Added support to inner comments in item     }
{                                   descriptions.                               }
{ Version 4.07, 25 Apr, 2025      - Fixed a bug in character deletion.          }
{                                 - Fixed a bug in moving up/down characters.   }
{                                 - Fixed a bug which caused the description    }
{                                   field to appear disabled for dependent      }
{                                   characters.                                 }
{                                 - Fixed a bug which caused the editing status }
{                                   indicator in the title bar when a file was  }
{                                   modified and then saved.                    }
{ Version 4.10, 2nd May, 2025     - Restored the Nexus and TNT options to the   }
{                                   Export menu from previous version 2.9.2.    }
{                                 - Restored the Nexus option to the Import     }
{                                   menu from previous version 2.9.2.           }
{ Version 4.20, 20 Sep, 2025      - Added numbering to items and characters in  }
{                                   matrix view.                                }
{                                 - Removed call to CleanData procedure to keep }
{                                   inner comments when importing DELTA datasets}
{===============================================================================}
unit Main;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, Classes, SysUtils, StrUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, ComCtrls, Menus, Clipbrd, IniFiles, HistoryFiles,
  CheckLst, LCLTranslator, ExtCtrls, StdCtrls, Grids, Zipper, Process,
  Math, Delta, Types, GetText, Nexus;

const
  Checked = 20;
  Unchecked = 21;
  Inapplicable = 23;
  Implicit = 30;

type

  { TMainForm }

  TMainForm = class(TForm)
    FileClearMRUItem: TMenuItem;
    CloneItem: TMenuItem;
    EditMergeCharacterItem: TMenuItem;
    FindDialog: TFindDialog;
    HelpMenuItem: TMenuItem;
    EditScriptItem: TMenuItem;
    CharacterListView: TListView;
    MatrixParsimonyItemTNT: TMenuItem;
    MatrixParsimonyItemPAUP: TMenuItem;
    ExportTextItem: TMenuItem;
    ExportSpreadsheetItem: TMenuItem;
    LanguageSpanishItem: TMenuItem;
    ExportSLIKSItem: TMenuItem;
    EditDescriptionItem: TMenuItem;
    ImportNexusItem: TMenuItem;
    ExportNexusItem: TMenuItem;
    ExportTNTItem: TMenuItem;
    N20: TMenuItem;
    SearchGotoLine: TMenuItem;
    SearchFindNextItem: TMenuItem;
    N12: TMenuItem;
    MatrixParsimonyItem: TMenuItem;
    MergeCharacter: TMenuItem;
    N9: TMenuItem;
    DescribeItem: TMenuItem;
    FilePrintItem: TMenuItem;
    LanguageFrenchItem: TMenuItem;
    EditCloneItem: TMenuItem;
    N8: TMenuItem;
    ExportXDELTAItem: TMenuItem;
    EditInsertItem: TMenuItem;
    EditInsertCharacterItem: TMenuItem;
    InsertCharacter: TMenuItem;
    InsertItem: TMenuItem;
    N31: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    MoveCharacterUp: TMenuItem;
    MoveCharacterDown: TMenuItem;
    MoveItemDown: TMenuItem;
    MoveItemUp: TMenuItem;
    N11: TMenuItem;
    PrintCharactersItem: TMenuItem;
    PrintItemsItem: TMenuItem;
    PrintNamesItem: TMenuItem;
    StatesMemo: TMemo;
    StatesListBox: TCheckListBox;
    FileNewItem: TMenuItem;
    FileCloseItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileExportItem: TMenuItem;
    EditChangeItem: TMenuItem;
    EditChangeCharacterItem: TMenuItem;
    EditDeleteCharacterItem: TMenuItem;
    EditDeleteItem: TMenuItem;
    KeyMenu: TMenuItem;
    KeyConventionalItem: TMenuItem;
    KeyInteractiveItem: TMenuItem;
    FeatureLabel: TLabel;
    ItemsMenu: TPopupMenu;
    AddItem: TMenuItem;
    EditItem: TMenuItem;
    DeleteItem: TMenuItem;
    CharsMenu: TPopupMenu;
    AddCharacter: TMenuItem;
    EditCharacter: TMenuItem;
    DeleteCharacter: TMenuItem;
    ListTab: TTabSheet;
    ItemListView: TListView;
    MatrixMenu: TMenuItem;
    MatrixOrdinationItem: TMenuItem;
    MatrixDistanceItem: TMenuItem;
    MatrixClusterItem: TMenuItem;
    MatrixTab: TTabSheet;
    N10: TMenuItem;
    EditTitleItem: TMenuItem;
    PageControl: TPageControl;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    DataMatrix: TStringGrid;
    SelectDirectoryDialog: TSelectDirectoryDialog;
    N7: TMenuItem;
    N6: TMenuItem;
    PrepareMenu: TMenuItem;
    PrepareUncodedItem: TMenuItem;
    PrepareTonatItem: TMenuItem;
    PrepareSummaryItem: TMenuItem;
    N5: TMenuItem;
    N4: TMenuItem;
    EditAddCharacterItem: TMenuItem;
    SearchMenu: TMenuItem;
    FileImportItem: TMenuItem;
    SearchFindItem: TMenuItem;
    N3: TMenuItem;
    N1: TMenuItem;
    ImportDeltaItem: TMenuItem;
    ImportTextItem: TMenuItem;
    ExportDELTAItem: TMenuItem;
    EditAddItem: TMenuItem;
    EditMenu: TMenuItem;
    FileExitItem: TMenuItem;
    FileMenu: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    HelpMenu: TMenuItem;
    HistoryFiles: THistoryFiles;
    ImageList: TImageList;
    MainMenu: TMainMenu;
    LanguagePortugueseItem: TMenuItem;
    LanguageMenu: TMenuItem;
    LanguageEnglishItem: TMenuItem;
    N2: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StatusLine: TStatusBar;
    ToolBar: TToolBar;
    NewBtn: TToolButton;
    OpenBtn: TToolButton;
    SaveBtn: TToolButton;
    S1: TToolButton;
    FindBtn: TToolButton;
    S2: TToolButton;
    TonatBtn: TToolButton;
    SummaryBtn: TToolButton;
    S3: TToolButton;
    KeyBtn: TToolButton;
    IntkeyBtn: TToolButton;
    S4: TToolButton;
    MatrixBtn: TToolButton;
    ClusterBtn: TToolButton;
    OrdinationBtn: TToolButton;
    S5: TToolButton;
    ExitBtn: TToolButton;
    ScriptBtn: TToolButton;
    S6: TToolButton;
    UncodedBtn: TToolButton;
    procedure CharacterListViewDblClick(Sender: TObject);
    procedure CharacterListViewKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure CharacterListViewMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure DataMatrixDrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure DataMatrixPrepareCanvas(Sender: TObject; aCol, aRow: integer;
      aState: TGridDrawState);
    procedure DataMatrixSelectCell(Sender: TObject; aCol, aRow: integer;
      var CanSelect: boolean);
    procedure EditAddCharacterItemClick(Sender: TObject);
    procedure EditAddItemClick(Sender: TObject);
    procedure EditChangeCharacterItemClick(Sender: TObject);
    procedure EditChangeItemClick(Sender: TObject);
    procedure EditCloneItemClick(Sender: TObject);
    procedure EditDeleteCharacterItemClick(Sender: TObject);
    procedure EditDeleteItemClick(Sender: TObject);
    procedure EditDescriptionItemClick(Sender: TObject);
    procedure EditInsertCharacterItemClick(Sender: TObject);
    procedure EditInsertItemClick(Sender: TObject);
    procedure EditMergeCharacterItemClick(Sender: TObject);
    procedure EditScriptItemClick(Sender: TObject);
    procedure EditTitleItemClick(Sender: TObject);
    procedure ExportDELTAItemClick(Sender: TObject);
    procedure ExportNexusItemClick(Sender: TObject);
    procedure ExportSLIKSItemClick(Sender: TObject);
    procedure ExportSpreadsheetItemClick(Sender: TObject);
    procedure ExportTextItemClick(Sender: TObject);
    procedure ExportTNTItemClick(Sender: TObject);
    procedure ExportXDELTAItemClick(Sender: TObject);
    procedure FileClearMRUItemClick(Sender: TObject);
    procedure FileCloseItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileSaveAsItemClick(Sender: TObject);
    procedure FileSaveItemClick(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of string);
    procedure HelpAboutItemClick(Sender: TObject);
    procedure HelpMenuItemClick(Sender: TObject);
    procedure HistoryFilesClickHistoryItem(Sender: TObject; Item: TMenuItem;
      const Filename: string);
    procedure ImportDeltaItemClick(Sender: TObject);
    procedure ImportNexusItemClick(Sender: TObject);
    procedure ImportTextItemClick(Sender: TObject);
    procedure ItemListViewDblClick(Sender: TObject);
    procedure ItemListViewKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure KeyConventionalItemClick(Sender: TObject);
    procedure KeyInteractiveItemClick(Sender: TObject);
    procedure LanguageEnglishItemClick(Sender: TObject);
    procedure LanguageFrenchItemClick(Sender: TObject);
    procedure LanguagePortugueseItemClick(Sender: TObject);
    procedure LanguageSpanishItemClick(Sender: TObject);
    procedure MatrixClusterItemClick(Sender: TObject);
    procedure MatrixDistanceItemClick(Sender: TObject);
    procedure MatrixOrdinationItemClick(Sender: TObject);
    procedure MatrixParsimonyItemPAUPClick(Sender: TObject);
    procedure MatrixParsimonyItemTNTClick(Sender: TObject);
    procedure MoveCharacterDownClick(Sender: TObject);
    procedure MoveCharacterUpClick(Sender: TObject);
    procedure MoveItemDownClick(Sender: TObject);
    procedure MoveItemUpClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure PrepareSummaryItemClick(Sender: TObject);
    procedure PrepareTonatItemClick(Sender: TObject);
    procedure PrepareUncodedItemClick(Sender: TObject);
    procedure PrintCharactersItemClick(Sender: TObject);
    procedure PrintItemsItemClick(Sender: TObject);
    procedure PrintNamesItemClick(Sender: TObject);
    procedure SearchFindItemClick(Sender: TObject);
    procedure SearchFindNextItemClick(Sender: TObject);
    procedure SearchGotoLineClick(Sender: TObject);
    procedure StatesListBoxItemClick(Sender: TObject; Index: integer);
  private
    { private declarations }
    FileIsOpen: boolean;
    FileIsSaved: boolean;
    FoundPos: integer;
    HasDistance: boolean;
    SelectedChar: integer;
    FLastHintItem: TListItem;
    function LocateR: boolean;
    function FindR: string;
    function SearchListView(LV: TListView; const S: string; Column: integer;
      P: integer): TListItem;
    function FindCol(SG: TStringGrid; C: integer; sFind: string; P: integer): integer;
    function CheckCharacters(Dir: string): boolean;
    function CheckItems(Dir: string): boolean;
    procedure AdjustWidth;
    procedure ListInapplicables(const depChar: string; const Deps: TStrings);
    procedure CheckInapplicables(SelectedIndex: integer);
    procedure UpdateMenuItems(Sender: TObject);
    procedure UpdateStatusBar(Sender: TObject);
    procedure UpdateTitleBar(Filename: string);
    procedure DeleteOneItem(var anArray: TItemList; const aPosition: integer);
    procedure DeleteOneCharacter(var anArray: TCharacterList; const aPosition: integer);
    procedure ExchangeCharacters(First, Second: integer);
    procedure ExchangeItems(First, Second: integer);
    procedure InsertOneItem(var anArray: TItemList; const Index: cardinal;
      const Value: Delta.TItem);
    procedure InsertOneCharacter(var anArray: TCharacterList;
      const Index: cardinal; const Value: Delta.TCharacter);
    procedure LoadItemList;
    procedure LoadCharacterList(SelectedIndex: integer = 0);
    procedure LoadMatrix;
    procedure LoadFile(Filename: string);
    procedure SaveFile(Filename: string);
    procedure ReadSettings(Sender: TObject);
    procedure WriteSettings(Sender: TObject);
    procedure ShowErrorLog(S: ansistring);
  public
    { public declarations }
    sLang: string;
    IntKeyPath: string;
    IntMatePath: string;
    RPath: string;
    TNTPath: string;
    PAUPPath: string;
    FileIsChanged: boolean;
    TreeState: integer;
  end;

var
  MainForm: TMainForm;
  Dataset: TDelta;

{ Helper routines }
function IsWindows: boolean;
function Is32bit: boolean;
function IsDigit(Ch: char): boolean;
function GetFileNameWithoutExt(Filenametouse: string): string;
function Capitalize(s: string): string;
function ExistWordInString(const AString: PChar; const ASearchString: string;
  ASearchOptions: TStringSearchOptions): boolean;
function ContainsChars(const Str: string; const Chars: TSysCharSet): boolean;
procedure Join(const Values: TStrings; var S: string; const sep: string);
procedure Split(const Values: TStrings; const S: string; const Delimiters: TSysCharSet);
procedure SplitString(Delimiter: char; Str: string; ListOfStrings: TStrings);
procedure CreateBackup(Filename: string);

implementation

uses About, Prepare, Tonat, Tokey, Toint, Todis, Cluster, Chars, Descrip,
  Viewer, Phylogen, Script;

  {$R *.lfm}

  {$I resources.inc}

function IsWindows: boolean;
begin
  {$IFDEF Windows}
  Result := True;
  {$ENDIF}
  {$IF DEFINED(DARWIN) or DEFINED(Linux) or DEFINED(Unix)}
  Result := False;
  {$ENDIF}
end;

function Is32bit: boolean;
begin
  {$IFDEF CPU32}
  Result := True;
  {$ENDIF}
  {$IFDEF CPU64}
  Result := False;
  {$ENDIF}
end;

function IsDigit(Ch: char): boolean;
begin
  IsDigit := Ch in ['0'..'9'];
end;

function GetFileNameWithoutExt(Filenametouse: string): string;
begin
  Result := ExtractFilename(Copy(Filenametouse, 1,
    RPos(ExtractFileExt(Filenametouse), Filenametouse) - 1));
end;

function ExtractFileFromArchive(archive, filename: string): boolean;
var
  ZipFile: TUnZipper;
  FileList: TStringList;
begin
  ZipFile := TUnZipper.Create;
  try
    ZipFile.FileName := archive;
    ZipFile.OutputPath := GetCurrentDir; //'.\tmp';
    FileList := TStringList.Create;
    try
      FileList.Add(filename);
      ZipFile.UnzipFiles(FileList);
    finally
      Result := False;
      FileList.Free;
    end;
  finally
    Result := True;
    ZipFile.Free;
  end;
end;

function Capitalize(s: string): string;
var
  flag: boolean;
  i: byte;
  t: string;
begin
  flag := True;
  s := AnsiLowerCase(s);
  t := EmptyStr;
  for i := 1 to Length(s) do
  begin
    if flag then
      t := t + AnsiUpperCase(s[i])
    else
      t := t + s[i];
    flag := (s[i] = ' ');
  end;
  Result := t;
end;

function ExistWordInString(const AString: PChar; const ASearchString: string;
  ASearchOptions: TStringSearchOptions): boolean;
var
  Size: integer;
begin
  Size := StrLen(aString);
  Result := SearchBuf(AString, Size, 0, 0, ASearchString, ASearchOptions) <> nil;
end;

procedure Join(const Values: TStrings; var S: string; const sep: string);
var
  L, I: integer;
begin
  if (Values <> nil) and (Values.Count > 0) then
  begin
    L := Length(Values[0]) + 1;
    I := 1;
    S := Values[0];
    while (L < 250) and (I < Values.Count) do
    begin
      S := S + sep + Values[I];
      Inc(I);
      if I > Values.Count - 1 then
        break;
      L := L + Length(Values[I]) + 1;
    end;
  end;
end;

function ContainsChars(const Str: string; const Chars: TSysCharSet): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 1 to Length(Str) do
  begin
    if Str[i] in Chars then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

procedure Split(const Values: TStrings; const S: string; const Delimiters: TSysCharSet);
var
  L: integer;
  C: string;
begin
  if Values <> nil then
  begin
    Values.Clear;
    if Length(S) = 1 then
    begin
      C := S;
      Values.Add(C);
    end
    else
    begin
      L := 1;
      while (L < Length(S)) do
      begin
        C := ExtractDelimited(L, S, Delimiters);
        if Length(C) > 0 then
          Values.Add(C);
        Inc(L);
      end;
    end;
  end;
end;

procedure SplitString(Delimiter: char; Str: string; ListOfStrings: TStrings);
begin
  ListOfStrings.Clear;
  ListOfStrings.Delimiter := Delimiter;
  ListOfStrings.StrictDelimiter := True;
  ListOfStrings.DelimitedText := Str;
end;

procedure CleanData(const filename: string);
var
  infile, outfile: TextFile;
  S: string;
begin
  if not FileExists(filename) then
    Exit;
  CreateBackup(filename);
  AssignFile(outfile, filename);
  Rewrite(outfile);
  AssignFile(infile, Concat(filename, '.bak'));
  Reset(infile);
  while not EOF(infile) do
  begin
    ReadLn(infile, S);
    S := OmitInnerComments(S);
    WriteLn(outfile, S);
  end;
  CloseFile(infile);
  CloseFile(outfile);
end;

procedure CreateBackup(Filename: string);
var
  BackupFilename: string;
begin
  BackupFilename := ChangeFileExt(Filename, '.bak');
  CopyFile(Filename, BackupFilename);
end;

procedure ToNex(Inputfile: string);
const
  missDefault = '?';
var
  title, Outputfile: string;
  infile, outfile: TextFile;
  missing: char;
  spp, chars: integer;  { spp = number of species,  chars = number of characters }
  nayme: array of string;  { names of species }
  Data: array of array of char;   { data matrix }

  procedure NewLine(i, j, k: integer);
  { go to new line if i is a multiple of j, indent k spaces }
  var
    m: integer;
  begin
    if (((i - 1) mod j) = 0) and (i > 1) then
    begin
      WriteLn(outfile);
      for m := 1 to k do
        Write(outfile, ' ');
    end;
  end;

  procedure InputNumbers; { input the numbers of species and of characters }
  var
    comline: string[5];
    Ch: char;
  begin
    Read(infile, comline);
    if EoLn(infile) then
      ReadLn(infile);
    title := '';
    while not (EoLn(infile)) do
    begin
      Read(infile, Ch);
      if Ch = #39 then
      begin
        Read(infile, Ch);
        repeat
          title := title + Ch;
          Read(infile, Ch);
        until Ch = #39;
        title := title;
        if Ch = #39 then
          Read(infile, chars, spp);
      end;
    end;
    if EoLn(infile) then
      ReadLn(infile);
    SetLength(nayme, spp);
    SetLength(Data, spp, chars);
  end;

  procedure ReadHennig; { input the names and character state data for species }
  const
    ValidChars = ['0'..'9', '?', '-', ' '];
  var
    i, j: integer;
    charstate: char;  { possible states are '0..9', '-', and '?' }
    namestr: string;
    question: boolean;
  begin
    question := False;
    for i := 0 to spp - 1 do
    begin
      ReadLn(infile, namestr);
      nayme[i] := namestr;
      for j := 0 to chars - 1 do
      begin
        repeat
          if EoLn(infile) then
            ReadLn(infile);
          Read(infile, charstate);
        until charstate <> ' ';
        if charstate = '?' then
          question := True;
        Data[i, j] := charstate;
      end;
      ReadLn(infile);
    end;
    if question then
      missing := '?'
    else
      missing := '-';
  end;

  procedure OpenFiles; {  open I/O files  }
  begin
    AssignFile(Infile, Inputfile);
    Reset(Infile);
    Outputfile := Concat(GetFileNameWithoutExt(Inputfile), '.nex');
    AssignFile(Outfile, Outputfile);
    Rewrite(Outfile);
  end;

  procedure WriteNEXUS;  { write NEXUS file }
  var
    i, j: integer;
  begin
    WriteLn(outfile, '#NEXUS');
    WriteLn(outfile);
    WriteLn(outfile, 'BEGIN DATA;');
    WriteLn(outfile, 'DIMENSIONS NTAX=', spp, ' NCHAR=', chars, ';');
    WriteLn(outfile);
    WriteLn(outfile, '[!', title, ']');
    WriteLn(outfile, 'FORMAT MISSING=', missing, ' SYMBOLS="0123456789";');
    WriteLn(outfile);
    WriteLn(outfile, 'MATRIX');
    for i := 0 to spp - 1 do
    begin
      WriteLn(outfile, #39, nayme[i], #39);
      for j := 0 to chars - 1 do
      begin
        NewLine(j, 55, 0);
        Write(outfile, Data[i, j]);
      end;
      WriteLn(outfile);
    end;
    WriteLn(outfile, ';');
    WriteLn(outfile);
    WriteLn(outfile, 'END;');
    WriteLn(outfile);
    WriteLn(outfile, 'BEGIN ASSUMPTIONS;');
    WriteLn(outfile, 'OPTIONS DEFTYPE=unord PolyTCount=MINSTEPS;');
    WriteLn(outfile, 'TYPESET * untitled = unord: 1-', chars, ';');
    WriteLn(outfile);
    WriteLn(outfile, 'WTSET * untitled = 1: 1-', chars, ';');
    WriteLn(outfile);
    WriteLn(outfile, 'END;');
  end;

begin
  OpenFiles;
  InputNumbers;
  ReadHennig;
  WriteNEXUS;
  CloseFile(Infile);
  CloseFile(Outfile);
end;

procedure XlsWriteCellLabel(XlsStream: TStream; const ACol, ARow: word;
  const AValue: string);
var
  L: word;
const
  {$J+}
  CXlsLabel: array[0..5] of word = ($204, 0, 0, 0, 0, 0);
  {$J-}
begin
  L := Length(AValue);
  CXlsLabel[1] := 8 + L;
  CXlsLabel[2] := ARow;
  CXlsLabel[3] := ACol;
  CXlsLabel[5] := L;
  XlsStream.WriteBuffer(CXlsLabel, SizeOf(CXlsLabel));
  XlsStream.WriteBuffer(Pointer(AValue)^, L);
end;

function SaveAsExcelFile(AGrid: TStringGrid; AFileName: string): boolean;
const
  {$J+}
  CXlsBof: array[0..5] of word = ($809, 8, 00, $10, 0, 0);
  {$J-}
  CXlsEof: array[0..1] of word = ($0A, 00);
var
  FStream: TFileStream;
  I, J: integer;
begin
  Result := False;
  FStream := TFileStream.Create(PChar(AFileName), fmCreate or fmOpenWrite);
  try
    CXlsBof[4] := 0;
    FStream.WriteBuffer(CXlsBof, SizeOf(CXlsBof));
    for i := 0 to AGrid.ColCount - 1 do
      for j := 0 to AGrid.RowCount - 1 do
        XlsWriteCellLabel(FStream, I, J, AGrid.cells[i, j]);
    FStream.WriteBuffer(CXlsEof, SizeOf(CXlsEof));
    Result := True;
  finally
    FStream.Free;
  end;
end;

{ TMainForm }

function TMainForm.LocateR: boolean;
begin
  if not FileExists(RPath) then
    RPath := '';
  if RPath = '' then
  begin
    if Copy(OSVersion, 1, Pos(' ', OSVersion) - 1) <> 'Windows' then
      RPath := '/usr/bin/Rscript'
    else
    begin
      Screen.Cursor := crHourGlass;
      RPath := FindR;
      if RPath <> '' then
        RPath := Concat(RPath, 'Rscript.exe');
      Screen.Cursor := crDefault;
    end;
    if RPath = '' then
    begin
      MessageDlg(strError, Format(strRNotFound, ['R']), mtError, [mbOK], 0);
      Result := False;
    end
    else
      WriteSettings(Self);
  end
  else
    Result := True;
end;

function TMainForm.FindR: string;
const
  FN = 'bin\RScript.exe';
  P = 'C:\Program Files\R';
var
  I: integer;
  LSearchResult: TStringList;

  procedure FileSearch(const dirName: string);
  var
    searchResult: TSearchRec;
  begin
    if FindFirst(dirName + '\*', faAnyFile, searchResult) = 0 then
    begin
      try
        repeat
          if (searchResult.Attr and faDirectory) = 0 then
          begin
            if SameText(ExtractFileExt(searchResult.Name), '.exe') then
              LSearchResult.Append(IncludeTrailingBackSlash(dirName) +
                searchResult.Name);
          end
          else if (searchResult.Name <> '.') and (searchResult.Name <> '..') then
            FileSearch(IncludeTrailingBackSlash(dirName) + searchResult.Name);
        until FindNext(searchResult) <> 0;
      finally
        FindClose(searchResult);
      end;
    end;
  end;

begin
  Result := '';
  LSearchResult := TStringList.Create;
  FileSearch(P);
  for I := 0 to LSearchResult.Count - 1 do
  begin
    if Pos(LowerCase(FN), LowerCase(LSearchResult[I])) > 0 then
      Result := ExtractFilePath(LSearchResult[I]);
  end;
  LSearchResult.Free;
end;

function TMainForm.SearchListView(LV: TListView; const S: string;
  Column, P: integer): TListItem;
var
  Item: TListItem;
  ItemText: string;
  Options: TStringSearchOptions;
begin
  Options := [soDown];
  if frMatchCase in FindDialog.Options then
    Options += [soMatchCase];
  if frWholeWord in FindDialog.Options then
    Options += [soWholeWord];
  Result := nil;
  if P = LV.Items.Count - 1 then
    P := -1;
  Item := LV.Items.Item[P + 1];
  while Item.Index < LV.Items.Count do
  begin
    if Column = 0 then
      ItemText := Item.Caption
    else
      ItemText := Item.SubItems[Column - 1];
    if ExistWordInString(PChar(ItemText), S, Options) then
    begin
      Result := Item;
      Break;
    end
    else if Item.Index = LV.Items.Count - 1 then
      break
    else
      Item := LV.Items[Item.Index + 1];
  end;
  if Result = nil then
  begin
    if P >= 0 then
      Result := SearchListView(LV, S, Column, -1);
  end;
end;

function TMainForm.FindCol(SG: TStringGrid; C: integer; sFind: string;
  P: integer): integer;
var
  I: integer;
  Options: TStringSearchOptions;
begin
  Options := [soDown];
  if frMatchCase in FindDialog.Options then
    Options += [soMatchCase];
  if frWholeWord in FindDialog.Options then
    Options += [soWholeWord];
  Result := 0;
  for I := P + 1 to DataMatrix.RowCount - 1 do
  begin
    if ExistWordInString(PChar(SG.Cells[C, I]), sFind, Options) then
    begin
      SG.Col := C;
      SG.Row := I;
      Result := I;
      Exit;
    end;
  end;
end;

function TMainForm.CheckCharacters(Dir: string): boolean;
var
  S: ansistring;
  sPath, ConforPath: string;
begin
  if not FileExists('checkc') then
    CreateCHECKC('checkc');
  sPath := ExtractFilePath(Application.ExeName);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if not RunCommand(ConforPath, ['checkc'], S, [poNoConsole]) then
  begin
    MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
    ShowErrorLog(S);
    Result := False;
  end;
end;

function TMainForm.CheckItems(Dir: string): boolean;
var
  S: ansistring;
  sPath, ConforPath: string;
begin
  if not FileExists('checki') then
    CreateCHECKC('checki');
  sPath := ExtractFilePath(Application.ExeName);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if not RunCommand(ConforPath, ['checki'], S, [poNoConsole]) then
  begin
    MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
    ShowErrorLog(S);
    Result := False;
  end;
end;

procedure TMainForm.DeleteOneItem(var anArray: TItemList; const aPosition: integer);
var
  lg, j: integer;
begin
  lg := Length(anArray);
  if aPosition > lg - 1 then
    Exit
  else if aPosition = lg - 1 then
  begin
    Setlength(anArray, lg - 1);
    Exit;
  end;
  for j := aPosition to lg - 2 do
    anArray[j] := anArray[j + 1];
  SetLength(anArray, lg - 1);
end;

procedure TMainForm.DeleteOneCharacter(var anArray: TCharacterList;
  const aPosition: integer);
var
  lg, j: integer;
begin
  lg := Length(anArray);
  if aPosition > lg - 1 then
    Exit
  else if aPosition = lg - 1 then
  begin
    Setlength(anArray, lg - 1);
    Exit;
  end;
  for j := aPosition to lg - 2 do
    anArray[j] := anArray[j + 1];
  SetLength(anArray, lg - 1);
end;

procedure TMainForm.ExchangeCharacters(First, Second: integer);
var
  tmpRec: Delta.TCharacter;
begin
  tmpRec := Dataset.CharacterList[First];
  Dataset.CharacterList[First] := Dataset.CharacterList[Second];
  Dataset.CharacterList[Second] := tmpRec;
  CharacterListView.Items.Exchange(First, Second);
end;

procedure TMainForm.ExchangeItems(First, Second: integer);
var
  tmpRec: Delta.TItem;
begin
  tmpRec := Dataset.ItemList[First];
  Dataset.ItemList[First] := Dataset.ItemList[Second];
  Dataset.ItemList[Second] := tmpRec;
  ItemListView.Items.Exchange(First, Second);
end;

procedure TMainForm.InsertOneItem(var anArray: TItemList; const Index: cardinal;
  const Value: Delta.TItem);
var
  ALength: cardinal;
  TailElements: cardinal;
begin
  ALength := Length(anArray);
  Assert(Index <= ALength);
  SetLength(anArray, ALength + 1);
  Finalize(anArray[ALength]);
  TailElements := ALength - Index;
  if TailElements > 0 then
    Move(anArray[Index], anArray[Index + 1], SizeOf(TItem) * TailElements);
  Initialize(anArray[Index]);
  anArray[Index] := Value;
end;

procedure TMainForm.InsertOneCharacter(var anArray: TCharacterList;
  const Index: cardinal; const Value: Delta.TCharacter);
var
  ALength: cardinal;
  TailElements: cardinal;
begin
  ALength := Length(anArray);
  Assert(Index <= ALength);
  SetLength(anArray, ALength + 1);
  Finalize(anArray[ALength]);
  TailElements := ALength - Index;
  if TailElements > 0 then
    Move(anArray[Index], anArray[Index + 1], SizeOf(TCharacter) * TailElements);
  Initialize(anArray[Index]);
  anArray[Index] := Value;
end;

procedure TMainForm.ListInapplicables(const depChar: string; const Deps: TStrings);
var
  Values: TStringList;
  I, CharNo, First, Last: integer;
  S, Aux: string;
begin
  Values := TStringList.Create;
  Values.Delimiter := ' ';
  Split(Values, depChar, [',', ':']);
  for I := 1 to Values.Count - 1 do
  begin
    Aux := Values[I];
    if (Pos('-', Aux) > 0) then
    begin
      S := ExtractDelimited(1, Aux, [':']);
      First := StrToInt(Copy(S, 1, Pos('-', S) - 1));
      Last := StrToInt(Copy(S, Pos('-', S) + 1, Length(S)));
      for CharNo := First to Last do
        Deps.Add(IntToStr(CharNo));
    end
    else
    begin
      CharNo := StrToIntDef(ExtractDelimited(1, Aux, [':']), -1);
      Deps.Add(IntToStr(CharNo));
    end;
  end;
  Values.Free;
end;

procedure TMainForm.CheckInapplicables(SelectedIndex: longint);
var
  S, Aux: string;
  I, J, CharNo, First, Last: integer;
  Values: TStringList;
  LParent: TTreeNode;
begin
  for J := 0 to Length(Dataset.CharacterList) - 1 do
  begin
    if Length(Dataset.CharacterList[J].charDependent) > 0 then
    begin
      Values := TStringList.Create;
      Split(Values, Dataset.CharacterList[J].charDependent, [':']);
      for I := 1 to Values.Count - 1 do
      begin
        Aux := Values[I];
        if (Pos('-', Aux) > 0) then
        begin
          S := ExtractDelimited(1, Aux, [':']);
          First := StrToIntDef(Copy(S, 1, Pos('-', S) - 1), -1);
          Last := StrToIntDef(Copy(S, Pos('-', S) + 1, Length(S)), -1);
          if (First < 0) or (Last < 0) then
            Exit;
        end
        else
        begin
          CharNo := StrToIntDef(ExtractDelimited(1, Aux, [':']), -1);
          if CharNo < 0 then
            Exit;
        end;
      end;
      Values.Free;
    end;
  end;
end;

procedure TMainForm.AdjustWidth;
var
  I: word;
begin
  with DataMatrix do
  begin
    for I := 1 to ColCount - 1 do
      DefaultColWidth := Canvas.TextWidth('ABCDEFGH');
    ColWidths[0] := Canvas.TextWidth('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  end;
end;

procedure TMainForm.UpdateMenuItems(Sender: TObject);
begin
  FileCloseItem.Enabled := FileIsOpen;
  FileSaveItem.Enabled := FileIsOpen;
  FileSaveAsItem.Enabled := FileIsOpen;
  FilePrintItem.Enabled := FileIsOpen;
  FileExportItem.Enabled := FileIsOpen;
  FileImportItem.Enabled := not FileIsOpen;
  FileClearMRUItem.Visible := HistoryFiles.Count > 0;
  EditAddItem.Enabled := FileIsOpen;
  EditInsertItem.Enabled := FileIsOpen;
  EditChangeItem.Enabled := FileIsOpen;
  EditDeleteItem.Enabled := FileIsOpen;
  EditCloneItem.Enabled := FileIsOpen;
  EditDescriptionItem.Enabled := FileIsOpen;
  EditAddCharacterItem.Enabled := FileIsOpen;
  EditInsertCharacterItem.Enabled := FileIsOpen;
  EditChangeCharacterItem.Enabled := FileIsOpen;
  EditDeleteCharacterItem.Enabled := FileIsOpen;
  EditMergeCharacterItem.Enabled := FileIsOpen;
  EditTitleItem.Enabled := FileIsOpen;
  EditScriptItem.Enabled := FileIsOpen;
  SearchFindItem.Enabled := FileIsOpen;
  SearchGotoLine.Enabled := FileIsOpen;
  SearchFindNextItem.Enabled := FileIsOpen;
  PrepareTonatItem.Enabled := FileIsOpen;
  PrepareSummaryItem.Enabled := FileIsOpen;
  PrepareUncodedItem.Enabled := FileIsOpen;
  KeyConventionalItem.Enabled := FileIsOpen;
  KeyInteractiveItem.Enabled := FileIsOpen;
  MatrixDistanceItem.Enabled := FileIsOpen;
  MatrixClusterItem.Enabled := FileIsOpen and hasDistance;
  MatrixOrdinationItem.Enabled := FileIsOpen and hasDistance;
  MatrixParsimonyItem.Enabled := FileIsOpen;
  SaveBtn.Enabled := FileIsOpen and FileIsChanged; //and (not FileIsSaved);
  FindBtn.Enabled := FileIsOpen;
  ScriptBtn.Enabled := FileIsOpen;
  TonatBtn.Enabled := FileIsOpen;
  SummaryBtn.Enabled := FileIsOpen;
  UncodedBtn.Enabled := FileIsOpen;
  KeyBtn.Enabled := FileIsOpen;
  IntkeyBtn.Enabled := FileIsOpen;
  MatrixBtn.Enabled := FileIsOpen;
  ClusterBtn.Enabled := FileIsOpen and hasDistance;
  OrdinationBtn.Enabled := FileIsOpen and hasDistance;
end;

procedure TMainForm.UpdateStatusBar(Sender: TObject);
begin
  if FileIsOpen then
    StatusLine.SimpleText := Dataset.Heading + ', ' +
      IntToStr(Length(Dataset.ItemList)) + ' ' + strItems + ', ' +
      IntToStr(Length(Dataset.CharacterList)) + ' ' + strCharacters
  else
    StatusLine.SimpleText := strReady;
end;

procedure TMainForm.UpdateTitleBar(Filename: string);
begin
  if Filename = '' then
    Filename := strUntitled;
  //if FileIsChanged and (not FileIsSaved) then
  if FileIsChanged then
    MainForm.Caption := '*' + Application.Title + ' - ' + ExtractFileName(Filename)
  else
    MainForm.Caption := Application.Title + ' - ' + ExtractFileName(Filename);
end;

procedure TMainForm.ReadSettings(Sender: TObject);
var
  sPath{, sLang}: string;
  IniFile: TIniFile;
begin
  sPath := GetAppConfigDir(False);
  IniFile := TIniFile.Create(sPath + 'fde.ini');
  sLang := IniFile.ReadString('Options', 'Language', 'en'); // First default is English
  {$IFDEF VER3}
  SetDefaultLang(sLang, 'languages', '', True);
  {$ELSE}
  SetDefaultLang(sLang, 'languages', True);
  {$ENDIF}
  case sLang of
    'en':
    begin
      LanguageEnglishItem.Checked := True;
      LanguagePortugueseItem.Checked := False;
      LanguageFrenchItem.Checked := False;
      LanguageSpanishItem.Checked := False;
    end;
    'fr':
    begin
      LanguageFrenchItem.Checked := True;
      LanguageEnglishItem.Checked := False;
      LanguagePortugueseItem.Checked := False;
      LanguageSpanishItem.Checked := False;
    end;
    'pt_br':
    begin
      LanguagePortugueseItem.Checked := True;
      LanguageEnglishItem.Checked := False;
      LanguageFrenchItem.Checked := False;
      LanguageSpanishItem.Checked := False;
    end;
    'es':
    begin
      LanguageSpanishItem.Checked := True;
      LanguageFrenchItem.Checked := False;
      LanguageEnglishItem.Checked := False;
      LanguagePortugueseItem.Checked := False;
    end;
  end;
  IntKeyPath := IniFile.ReadString('Options', 'IntKeyPath', '');
  IntMatePath := IniFile.ReadString('Options', 'IntMatePath', '');
  RPath := IniFile.ReadString('Options', 'RPath', '');
  TNTPath := IniFile.ReadString('Options', 'TNTPath', '');
  PAUPPath := IniFile.ReadString('Options', 'PAUPPath', '');
  Left := IniFile.ReadInteger('MainWindow', 'Left', Left);
  Top := IniFile.ReadInteger('MainWindow', 'Top', Top);
  Width := IniFile.ReadInteger('MainWindow', 'Width', Width);
  Height := IniFile.ReadInteger('MainWindow', 'Height', Height);
  WindowState := TWindowState(IniFile.ReadInteger('MainWindow', 'State',
    integer(WindowState)));
  PageControl.TabIndex := IniFile.ReadInteger('MainWindow', 'ActivePage', 0);
  TreeState := IniFile.ReadInteger('MainWindow', 'TreeState', 1);
  IniFile.Free;
end;

procedure TMainForm.WriteSettings(Sender: TObject);
var
  sPath: string;
  IniFile: TIniFile;
begin
  sPath := GetAppConfigDir(False);
  IniFile := TIniFile.Create(sPath + 'fde.ini');
  IniFile.WriteString('Options', 'Language', sLang);
  IniFile.WriteString('Options', 'IntKeyPath', IntKeyPath);
  IniFile.WriteString('Options', 'IntMatePath', IntMatePath);
  IniFile.WriteString('Options', 'RPath', RPath);
  IniFile.WriteString('Options', 'TNTPath', TNTPath);
  IniFile.WriteString('Options', 'PAUPPath', PAUPPath);
  IniFile.WriteInteger('MainWindow', 'Left', Left);
  IniFile.WriteInteger('MainWindow', 'Top', Top);
  IniFile.WriteInteger('MainWindow', 'Width', Width);
  IniFile.WriteInteger('MainWindow', 'Height', Height);
  IniFile.WriteInteger('MainWindow', 'State', integer(WindowState));
  IniFile.WriteInteger('MainWindow', 'ActivePage', PageControl.TabIndex);
  IniFile.WriteInteger('MainWindow', 'TreeState', TreeState);
  IniFile.Free;
end;

procedure TMainForm.ShowErrorLog(S: ansistring);
begin
  with ViewerForm do
  begin
    Caption := 'Error Log';
    ScrollBox.Visible := False;
    ImageViewer.Visible := False;
    HtmlViewer.Visible := False;
    TextViewer.Visible := True;
    TextViewer.Text := S;
    Show;
  end;
end;

procedure TMainForm.LoadItemList;
var
  I: integer;
  Item: TListItem;
begin
  ItemListView.Columns[0].Caption :=
    Capitalize(strItems) + ' (' + IntToStr(Length(Dataset.ItemList)) + ')';
  ItemListView.Items.Clear;
  for I := 0 to Length(Dataset.ItemList) - 1 do
  begin
    Item := ItemListView.Items.Add;
    Item.Caption := IntToStr(I + 1) + '. ' + (Dataset.ItemList[I].itemName) +
      ' ' + Dataset.ItemList[I].itemComment;
  end;
end;

procedure TMainForm.LoadMatrix;
var
  I, J, NRows, NCols: integer;
  Attribute: string;
  CanSelect: boolean;
begin
  NRows := Length(Dataset.ItemList);
  NCols := Length(Dataset.CharacterList);
  DataMatrix.RowCount := NRows + 1;
  DataMatrix.ColCount := NCols + 1;
  for I := 0 to NRows - 1 do
    DataMatrix.Cells[0, I + 1] :=
      IntToStr(I + 1) + '. ' + Dataset.ItemList[I].itemName + ' ' +
      Dataset.ItemList[I].itemComment;
  for J := 0 to NCols - 1 do
    DataMatrix.Cells[J + 1, 0] :=
      IntToStr(J + 1) + '. ' + Dataset.CharacterList[J].charName;
  for J := 0 to NCols - 1 do
  begin
    for I := 0 to NRows - 1 do
    begin
      Attribute := Dataset.ItemList[I].itemAttributes[J];
      if (Dataset.CharacterList[J].charType <> 'TE') then
        Attribute := Delta.RemoveComments(Attribute);
      DataMatrix.Cells[J + 1, I + 1] := Attribute;
    end;
  end;
  DataMatrix.TopRow := 0;
  AdjustWidth;
  DataMatrix.Refresh;
  DataMatrixSelectCell(Self, 1, 1, CanSelect);
end;

procedure TMainForm.LoadCharacterList(SelectedIndex: integer = 0);
var
  J: integer;
  Character: TListItem;
begin
  CharacterListView.Columns[0].Caption :=
    Capitalize(strCharacters) + ' (' + IntToStr(Length(Dataset.CharacterList)) + ')';
  CharacterListView.Items.Clear;
  if SelectedIndex >= 0 then
  begin
    for J := 0 to Length(Dataset.CharacterList) - 1 do
    begin
      Character := CharacterListView.Items.Add;
      Character.Caption := IntToStr(J + 1) + '. ' + Dataset.CharacterList[J].charName;
      if (Dataset.CharacterList[J].charType = 'UM') then
        Character.ImageIndex := 18
      else if (Dataset.CharacterList[J].charType = 'OM') then
        Character.ImageIndex := 28
      else if (Dataset.CharacterList[J].charType = 'IN') then
        Character.ImageIndex := 17
      else if (Dataset.CharacterList[J].charType = 'RN') then
        Character.ImageIndex := 27
      else if (Dataset.CharacterList[J].charType = 'TE') then
        Character.ImageIndex := 19;
    end;
  end;
end;

procedure TMainForm.LoadFile(Filename: string);
var
  I: integer;
  UnZipper: TUnZipper;
begin
  ChDir(ExtractFilePath(Filename));
  OpenDialog.FileName := Filename;
  SaveDialog.FileName := FileName;
  HistoryFiles.UpdateList(Filename);
  UnZipper := TUnZipper.Create;
  try
    UnZipper.FileName := Filename;
    UnZipper.OutputPath := GetCurrentDir;
    UnZipper.UnZipAllFiles;
  finally
    UnZipper.Free;
  end;
  Screen.Cursor := crHourGlass;
  Dataset := Delta.ReadDelta('chars', 'items', 'specs', 'cnotes');
  LoadItemList;
  if ItemListView.Selected <> nil then
    I := ItemListView.Selected.Index
  else
    I := 0;
  if CharacterListView.Selected <> nil then
    SelectedChar := CharacterListView.Selected.Index
  else
    SelectedChar := 0;
  LoadCharacterList(I);
  LoadMatrix;
  Screen.Cursor := crDefault;
  FileIsOpen := True;
  FileIsChanged := False;
  FileIsSaved := False;
  PageControl.Visible := True;
  UpdateMenuItems(Self);
  UpdateStatusBar(Self);
  UpdateTitleBar(Filename);
  ItemListView.Selected := ItemListView.Items[0];
end;

procedure TMainForm.SaveFile(Filename: string);
const
  FileList: array[1..16] of string = ('chars', 'items', 'specs', 'cnotes',
    'tonat', 'tokey', 'todis', 'toint', 'tohen', 'key', 'summary', 'dist',
    'uncoded', 'cimages', 'timages', 'intkey.ink');
var
  I: integer;
  OutZipper: TZipper;
begin
  FileIsSaved := False;
  if (Length(Dataset.ItemList) = 0) then
  begin
    MessageDlg(strInformation, strItemListEmpty, mtInformation, [mbOK], 0);
    Exit;
  end;
  if (Length(Dataset.CharacterList) = 0) then
  begin
    MessageDlg(strInformation, strCharListEmpty, mtInformation, [mbOK], 0);
    Exit;
  end;
  CreateBackup(Filename);
  Delta.WriteDelta(Dataset, 'chars', 'items', 'specs', 'cnotes');
  OutZipper := TZipper.Create;
  OutZipper.FileName := Filename;
  try
    try
      for I := 1 to Length(FileList) do
      begin
        if FileExists(FileList[I]) then
          OutZipper.Entries.AddFileEntry(FileList[i]);
      end;
      OutZipper.ZipAllFiles;
    finally
      OutZipper.Free;
      //for I := 1 to Length(FileList) do
      //begin
      //  if FileExists(FileList[I]) then
      //    DeleteFile(FileList[I]);
      //end;
    end;
    FileIsSaved := True;
    FileIsChanged := False;
  except
    MessageDlg(strError, Format(strSaveError, [Filename]), mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.FileOpenItemClick(Sender: TObject);
begin
  OpenDialog.DefaultExt := '.dtz';
  OpenDialog.Filter := strDtzFilter;
  if OpenDialog.Execute then
  begin
    LoadFile(OpenDialog.FileName);
    if PageControl.TabIndex = 0 then
      ItemListView.SetFocus;
  end;
end;

procedure TMainForm.FileSaveAsItemClick(Sender: TObject);
begin
  SaveDialog.Title := strSaveFile;
  SaveDialog.DefaultExt := '.dtz';
  SaveDialog.Filter := strDtzFilter;
  if SaveDialog.Execute then
  begin
    SaveFile(SaveDialog.FileName);
    UpdateTitleBar(SaveDialog.FileName);
  end;
end;

procedure TMainForm.FileSaveItemClick(Sender: TObject);
begin
  if AnsiContainsStr(SaveDialog.Filename, strUntitled) then
    FileSaveAsItemClick(Self)
  else
  begin
    SaveFile(SaveDialog.FileName);
    UpdateTitleBar(SaveDialog.FileName);
  end;
  if SaveBtn.Enabled = True then
    SaveBtn.Enabled := False;
  ;
end;

procedure TMainForm.FindDialogFind(Sender: TObject);
var
  Item: TListItem;
begin
  FindDialog.CloseDialog;
  if ItemListView.Focused then
  begin
    if ItemListView.ItemIndex >= 0 then
      FoundPos := ItemListView.ItemIndex
    else
      FoundPos := -1;
    Item := SearchListView(ItemListView, FindDialog.FindText, 0, FoundPos);
    if Item <> nil then
    begin
      ItemListView.Selected := Item;
      Item.MakeVisible(True);
      ItemListView.SetFocus;
    end
    else
      MessageDlg(strInformation, strTextNotFound, mtInformation, [mbOK], 0);
  end
  else if CharacterListView.Focused then
  begin
    if CharacterListView.ItemIndex >= 0 then
      FoundPos := CharacterListView.ItemIndex
    else
      FoundPos := -1;
    Item := SearchListView(CharacterListView, FindDialog.FindText, 0, FoundPos);
    if Item <> nil then
    begin
      CharacterListView.Selected := Item;
      Item.MakeVisible(True);
      CharacterListView.SetFocus;
    end
    else
      MessageDlg(strInformation, strTextNotFound, mtInformation, [mbOK], 0);////}
  end
  else if DataMatrix.Focused then
  begin
    if FindCol(DataMatrix, DataMatrix.Col, FindDialog.FindText, FoundPos) = 0 then
      MessageDlg(strInformation, strTextNotFound, mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  Reply, Ok: boolean;
begin
  Reply := MessageDlg(strConfirmation, strQuit, mtConfirmation,
    [mbYes, mbNo], 0) = mrYes;
  if Reply then
  begin
    Ok := False;
    if FileIsChanged and (not FileIsSaved) then
      Ok := MessageDlg(strConfirmation, strSave, mtConfirmation,
        [mbYes, mbNo], 0) = mrYes;
    if Ok then
      FileSaveAsItemClick(Self);
    CanClose := True;
  end
  else
    CanClose := False;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s, sPath: string;
  i: integer;
begin
  ReadSettings(Self);
  sPath := GetAppConfigDir(False);
  HistoryFiles.LocalPath := sPath;
  HistoryFiles.IniFile := sPath + 'fde.ini';
  HistoryFiles.UpdateParentMenu;
  FileIsOpen := False;
  FileIsChanged := False;
  FileIsSaved := False;
  HasDistance := False;
  PageControl.Visible := False;
  UpdateMenuItems(Self);
  Dataset := TDelta.Create;
  for i := 0 to StatesListBox.Items.Count - 1 do
    StatesListBox.ItemEnabled[i] := False;
  {$IFDEF WINDOWS}
  if ParamCount > 0 then
  begin
    s := ParamStr(1);
    if ExtractFileExt(s) = '.dtz' then
      LoadFile(s);
  end;
  {$ENDIF}
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  WriteSettings(Self);
  if Dataset <> nil then
    Dataset.Free;
end;

procedure TMainForm.FormDropFiles(Sender: TObject; const FileNames: array of string);
var
  s: string;
begin
  s := Filenames[0];
  if ExtractFileExt(s) = '.dtz' then
  begin
    LoadFile(s);
    if PageControl.TabIndex = 0 then
      ItemListView.SetFocus;
  end;
end;

procedure TMainForm.HelpAboutItemClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.HelpMenuItemClick(Sender: TObject);
begin
  OpenDocument('fde.pdf');
end;

procedure TMainForm.HistoryFilesClickHistoryItem(Sender: TObject;
  Item: TMenuItem; const Filename: string);
begin
  if FileExists(Filename) then
  begin
    LoadFile(Filename);
    if PageControl.TabIndex = 0 then
      ItemListView.SetFocus;
  end
  else
    MessageDlg(strError, strNotFound, mtError, [mbOK], 0);
end;

procedure TMainForm.ImportDeltaItemClick(Sender: TObject);
var
  {CurDir,} Directory: string;
  sPath, ConforPath: string;
  S: ansistring;
  Ok: boolean;
  Zipper: TZipper;
begin
  Ok := False;
  sPath := ExtractFilePath(Application.ExeName);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  SelectDirectoryDialog.Filename := '';
  if SelectDirectoryDialog.Execute then
  begin
    Directory := SelectDirectoryDialog.Filename;
    ChDir(Directory);
    if FileExists('specs') then
      Ok := True
    else
      MessageDlg(strInformation, Format(strNotFoundDir, ['SPECS', Directory]),
        mtInformation, [mbOK], 0);
    if FileExists('chars') then
      Ok := True
    else
      MessageDlg(strInformation, Format(strNotFoundDir, ['CHARS', Directory]),
        mtInformation, [mbOK], 0);
    if FileExists('items') then
      Ok := True
    else
      MessageDlg(strInformation, Format(strNotFoundDir, ['ITEMS', Directory]),
        mtInformation, [mbOK], 0);
    if Ok then
    begin
      CreateCHECKC('checkc', Dataset.Heading);
      if not RunCommand(ConforPath, ['checkc'], S, [poNoConsole]) then
      begin
        MessageDlg(strError, Format(strReadError, ['CHARS']), mtError, [mbOK], 0);
        ShowErrorLog(S);
        Ok := False;
      end;
    end;
    if Ok then
    begin
      CreateCHECKI('checki', Dataset.Heading);
      if not RunCommand(ConforPath, ['checki'], S, [poNoConsole]) then
      begin
        MessageDlg(strError, Format(strReadError, ['ITEMS']), mtError, [mbOK], 0);
        ShowErrorLog(S);
        Ok := False;
      end;
    end;
    if Ok then
    begin
      SaveDialog.FileName := '';
      SaveDialog.Title := strSaveFile;
      SaveDialog.DefaultExt := '.dtz';
      SaveDialog.Filter := strDtzFilter;
      if SaveDialog.Execute then
      begin
        Screen.Cursor := crHourGlass;
        //CleanData('chars');
        //CleanData('items');
        //if FileExists('cnotes') then
        //  CleanData('cnotes');
        Zipper := TZipper.Create;
        Zipper.FileName := SaveDialog.FileName;
        try
          Zipper.Entries.AddFileEntry('chars');
          Zipper.Entries.AddFileEntry('items');
          Zipper.Entries.AddFileEntry('specs');
          if FileExists('cnotes') then
            Zipper.Entries.AddFileEntry('cnotes');
          Zipper.ZipAllFiles;
        finally
          Zipper.Free;
        end;
        Screen.Cursor := crDefault;
        MessageDlg(strInformation, Format(strImport,
          [ExtractFileName(SaveDialog.FileName)]),
          mtInformation, [mbOK], 0);
        LoadFile(SaveDialog.FileName);
        if PageControl.TabIndex = 0 then
          ItemListView.SetFocus;
        ChDir(ExtractFilePath(SaveDialog.FileName));
      end;
    end;
    //ChDir(CurDir);
  end;
end;

procedure TMainForm.ImportNexusItemClick(Sender: TObject);
var
  i, j, max, size: integer;
  title, attribute: string;
  outfile: TextFile;
  nstates: TStringList;
  Zipper: TZipper;
  NxData: TNexus;
begin
  OpenDialog.FileName := '';
  OpenDialog.Title := strOpenFile;
  OpenDialog.DefaultExt := '.nex';
  OpenDialog.Filter := strNEXUSFilter;
  if OpenDialog.Execute then
  begin
    title := InputBox(strNewCaption, strNewPrompt, '');
    NxData := Nexus.ReadNexus(OpenDialog.FileName);
    AssignFile(outfile, 'CHARS');
    Rewrite(outfile);
    WriteLn(outfile, '*SHOW - ', title, ' - character list.');
    WriteLn(outfile);
    WriteLn(outfile, '*CHARACTER LIST');
    WriteLn(outfile);
    nstates := TStringList.Create;
    nstates.Delimiter := ' ';
    max := 0;
    for i := 0 to Length(NxData.CharList) - 1 do
    begin
      WriteLn(outfile, '#', i + 1, '. ', NxData.CharList[i].charName, '/');
      if NxData.CharList[i].charStates.Count > max then
        max := NxData.CharList[i].charStates.Count;
      if NxData.CharList[i].charStates.Count > 2 then
        nstates.Add(IntToStr(i + 1) + ',' + IntToStr(
          NxData.CharList[i].charStates.Count));
      for j := 0 to NxData.CharList[i].charStates.Count - 1 do
        WriteLn(outfile, StringOfChar(' ', 8), j + 1, '. ',
          NxData.CharList[i].charStates[j], '/');
      WriteLn(outfile);
    end;
    CloseFile(outfile);
    AssignFile(outfile, 'ITEMS');
    Rewrite(outfile);
    WriteLn(outfile, '*SHOW - ', title, ' - item descriptions.');
    WriteLn(outfile);
    WriteLn(outfile, '*ITEM DESCRIPTIONS');
    WriteLn(outfile);
    for i := 0 to Length(NxData.TaxaList) - 1 do
    begin
      WriteLn(outfile, '# ', NxData.TaxaList[i].taxonName, '/');
      for j := 0 to NxData.TaxaList[i].taxonAttributes.Count - 1 do
      begin
        attribute := NxData.TaxaList[i].taxonAttributes[j];
        Write(outfile, IntToStr(j + 1), ',', IfThen(attribute =
          '?', 'U', attribute), ' ');
      end;
      WriteLn(outfile);
      WriteLn(outfile);
    end;
    CloseFile(outfile);
    AssignFile(outfile, 'SPECS');
    Rewrite(outfile);
    WriteLn(outfile, '*SHOW - ', title, ' - specifications.');
    WriteLn(outfile);
    WriteLn(outfile, '*NUMBER OF CHARACTERS ', IntToStr(Length(NxData.CharList)));
    WriteLn(outfile, '*MAXIMUM NUMBER OF STATES ', IntToStr(max));
    WriteLn(outfile, '*MAXIMUM NUMBER OF ITEMS ', IntToStr(Length(NxData.TaxaList)));
    size := Length(NxData.CharList) * 20;
    if size < 2000 then
      size := 2000;
    WriteLn(outfile, '*DATA BUFFER SIZE ', IntToStr(size));
    WriteLn(outfile);
    Write(outfile, '*CHARACTER TYPES 1-', IntToStr(Length(NxData.CharList)), ',UM');
    WriteLn(outfile);
    WriteLn(outfile);
    WriteLn(outfile, '*NUMBERS OF STATES ', nstates.DelimitedText);
    CloseFile(outfile);
    nstates.Free;
    SaveDialog.FileName := ChangeFileExt(OpenDialog.FileName, '.dtz');
    SaveDialog.Title := strSaveFile;
    SaveDialog.DefaultExt := '.dtz';
    SaveDialog.Filter := strDtzFilter;
    if SaveDialog.Execute then
    begin
      Zipper := TZipper.Create;
      Zipper.FileName := SaveDialog.FileName;
      try
        Zipper.Entries.AddFileEntry('chars');
        Zipper.Entries.AddFileEntry('items');
        Zipper.Entries.AddFileEntry('specs');
        Zipper.ZipAllFiles;
      finally
        Zipper.Free;
      end;
      MessageDlg(strInformation, Format(strImport,
        [ExtractFileName(SaveDialog.FileName)]),
        mtInformation, [mbOK], 0);
      LoadFile(SaveDialog.FileName);
      if PageControl.TabIndex = 0 then
        ItemListView.SetFocus;
    end;
    NxData.Free;
  end;
end;

procedure TMainForm.ImportTextItemClick(Sender: TObject);
var
  i, nchar, ntax, size: integer;
  title, header, row: string;
  infile, outfile: TextFile;
  ts: TStringList;
  Zipper: TZipper;
begin
  OpenDialog.FileName := '';
  OpenDialog.Title := strOpenFile;
  OpenDialog.DefaultExt := '.csv';
  OpenDialog.Filter := strCsvFilter;
  if OpenDialog.Execute then
  begin
    nchar := 0;
    ntax := 0;
    title := InputBox(strNewCaption, strNewPrompt, '');
    AssignFile(infile, OpenDialog.FileName);
    Reset(infile);
    ReadLn(infile, header);
    AssignFile(outfile, 'CHARS');
    Rewrite(outfile);
    WriteLn(outfile, '*SHOW - ', title, ' - character list.');
    WriteLn(outfile);
    WriteLn(outfile, '*CHARACTER LIST');
    WriteLn(outfile);
    ts := TStringList.Create;
    ts.StrictDelimiter := True;
    ts.CommaText := header;
    for i := 1 to ts.Count - 1 do
    begin
      WriteLn(outfile, '#', IntToStr(i), '. ', ts[i], '/');
      WriteLn(outfile);
      Inc(nchar);
    end;
    ts.Free;
    CloseFile(outfile);
    AssignFile(outfile, 'ITEMS');
    Rewrite(outfile);
    WriteLn(outfile, '*SHOW - ', title, ' - item descriptions.');
    WriteLn(outfile);
    WriteLn(outfile, '*ITEM DESCRIPTIONS');
    WriteLn(outfile);
    ts := TStringList.Create;
    ts.StrictDelimiter := True;
    while not EOF(infile) do
    begin
      ReadLn(infile, row);
      ts.CommaText := row;
      Inc(ntax);
      WriteLn(outfile, '# ', ts[0], '/');
      for i := 1 to ts.Count - 1 do
        Write(outfile, IntToStr(i), ',', IfThen(ts[i] = '', 'U', ts[i]), ' ');
      WriteLn(outfile);
      WriteLn(outfile);
    end;
    ts.Free;
    CloseFile(outfile);
    CloseFile(infile);
    AssignFile(outfile, 'SPECS');
    Rewrite(outfile);
    WriteLn(outfile, '*SHOW - ', title, ' - specifications.');
    WriteLn(outfile);
    WriteLn(outfile, '*NUMBER OF CHARACTERS ', IntToStr(nchar));
    WriteLn(outfile, '*MAXIMUM NUMBER OF STATES ');
    WriteLn(outfile, '*MAXIMUM NUMBER OF ITEMS ', IntToStr(ntax));
    size := nchar * 20;
    if size < 2000 then
      size := 2000;
    WriteLn(outfile, '*DATA BUFFER SIZE ', IntToStr(size));
    WriteLn(outfile);
    Write(outfile, '*CHARACTER TYPES ');
    for i := 1 to nchar do
      Write(outfile, IntToStr(i), ',TE ');
    WriteLn(outfile);
    WriteLn(outfile);
    WriteLn(outfile, '*NUMBERS OF STATES ');
    CloseFile(outfile);
    SaveDialog.FileName := ChangeFileExt(ExtractFileName(OpenDialog.FileName), '.dtz');
    SaveDialog.Title := strSaveFile;
    SaveDialog.DefaultExt := '.dtz';
    SaveDialog.Filter := strDtzFilter;
    if SaveDialog.Execute then
    begin
      Zipper := TZipper.Create;
      Zipper.FileName := SaveDialog.FileName;
      try
        Zipper.Entries.AddFileEntry('chars');
        Zipper.Entries.AddFileEntry('items');
        Zipper.Entries.AddFileEntry('specs');
        Zipper.ZipAllFiles;
      finally
        Zipper.Free;
      end;
      MessageDlg(strInformation, Format(strImport,
        [ExtractFileName(SaveDialog.FileName)]),
        mtInformation, [mbOK], 0);
      LoadFile(SaveDialog.FileName);
      if PageControl.TabIndex = 0 then
        ItemListView.SetFocus;
    end;
  end;
end;

procedure TMainForm.ItemListViewDblClick(Sender: TObject);
begin
  EditChangeItemClick(Self);
end;

procedure TMainForm.ItemListViewKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    EditChangeItemClick(Self);
end;

procedure TMainForm.KeyConventionalItemClick(Sender: TObject);
var
  UseNormalValues, CharacterReliabilities, KeyStates, IncludeItems,
  IncludeCharacters: string;
  AddCharacterNumbers, NoBrackettedKey, NoTabularKey: boolean;
  NumberOfConfirmatoryCharacters: integer;
  TreatCharactersAsVariable, sPath, ConforPath, KeyPath: string;
  ABase, RBase, Reuse, Varywt: double;
  PrintWidth: integer;
  Extension: string;
  S: ansistring;
  FS: TFileStream;
begin
  sPath := ExtractFilePath(Application.ExeName);
  DefaultFormatSettings.DecimalSeparator := '.';
  if FileExists('tokey') then
  begin
    UseNormalValues := Delta.ReadDirective('tokey', '*USE NORMAL VALUES', True);
    CharacterReliabilities := Delta.ReadDirective('tokey',
      '*CHARACTER RELIABILITIES', True);
    KeyStates := Delta.ReadDirective('tokey', '*KEY STATES', True);
    IncludeItems := Delta.ReadDirective('tokey', '*INCLUDE ITEMS', True);
    IncludeCharacters := Delta.ReadDirective('tokey', '*INCLUDE CHARACTERS', True);
  end
  else
  begin
    UseNormalValues := '';
    CharacterReliabilities := '';
    KeyStates := '';
    IncludeItems := '';
    IncludeCharacters := '';
  end;
  if FileExists('key') then
  begin
    if Delta.ReadDirective('key', '*ADD CHARACTER NUMBERS') = '' then
      AddCharacterNumbers := False
    else
      AddCharacterNumbers := True;
    if Delta.ReadDirective('key', '*NO BRACKETTED KEY') = '' then
      NoBrackettedKey := False
    else
      NoBrackettedKey := True;
    if Delta.ReadDirective('key', '*NO TABULAR KEY') = '' then
      NoTabularKey := False
    else
      NoTabularKey := True;
    NumberOfConfirmatoryCharacters :=
      StrToIntDef(Delta.ReadDirective('key',
      '*NUMBER OF CONFIRMATORY CHARACTERS', True), 0);
    TreatCharactersAsVariable :=
      Delta.ReadDirective('key', '*TREAT CHARACTERS AS VARIABLE', True);
    ABase := StrToFloatDef(Delta.ReadDirective('key', '*ABASE', True), 1.2);
    RBase := StrToFloatDef(Delta.ReadDirective('key', '*RBASE', True), 1.4);
    Reuse := StrToFloatDef(Delta.ReadDirective('key', '*REUSE', True), 1.01);
    Varywt := StrToFloatDef(Delta.ReadDirective('key', '*VARYWT', True), 0.8);
    PrintWidth := StrToIntDef(Delta.ReadDirective('key', '*PRINT WIDTH', True), 80);
  end
  else
  begin
    AddCharacterNumbers := False;
    NoBrackettedKey := False;
    NoTabularKey := True;
    NumberOfConfirmatoryCharacters := 0;
    TreatCharactersAsVariable := '';
    ABase := 1.2;
    RBase := 1.4;
    Reuse := 1.01;
    Varywt := 0.8;
    PrintWidth := 80;
  end;
  with KeyForm do
  begin
    EditHeading.Text := Dataset.Heading;
    CheckBoxAddCharacterNumbers.Checked := AddCharacterNumbers;
    CheckBoxNoBrackettedKey.Checked := NoBrackettedKey;
    CheckBoxNoTabularKey.Checked := NoTabularKey;
    SpinEditNumberOfConfirmatoryCharacters.Value := NumberOfConfirmatoryCharacters;
    EditTreatCharactersAsVariable.Text := TreatCharactersAsVariable;
    EditUseNormalValues.Text := UseNormalValues;
    EditCharacterReliabilities.Text := CharacterReliabilities;
    EditKeyStates.Text := KeyStates;
    FloatSpinEditABASE.Value := ABase;
    FloatSpinEditRBASE.Value := RBase;
    FloatSpinEditREUSE.Value := Reuse;
    FloatSpinEditVARYWT.Value := Varywt;
    EditIncludeItems.Text := IncludeItems;
    EditIncludeCharacters.Text := IncludeCharacters;
    SpinEditPrintWidth.Value := PrintWidth;
  end;
  if KeyForm.ShowModal = mrOk then
  begin
    AddCharacterNumbers := KeyForm.CheckBoxAddCharacterNumbers.Checked;
    NoBrackettedKey := KeyForm.CheckBoxNoBrackettedKey.Checked;
    NoTabularKey := KeyForm.CheckBoxNoTabularKey.Checked;
    NumberOfConfirmatoryCharacters :=
      KeyForm.SpinEditNumberOfConfirmatoryCharacters.Value;
    TreatCharactersAsVariable := KeyForm.EditTreatCharactersAsVariable.Text;
    UseNormalValues := KeyForm.EditUseNormalValues.Text;
    CharacterReliabilities := KeyForm.EditCharacterReliabilities.Text;
    KeyStates := KeyForm.EditKeyStates.Text;
    ABase := KeyForm.FloatSpinEditABASE.Value;
    RBase := KeyForm.FloatSpinEditRBASE.Value;
    Reuse := KeyForm.FloatSpinEditREUSE.Value;
    Varywt := KeyForm.FloatSpinEditVARYWT.Value;
    IncludeItems := KeyForm.EditIncludeItems.Text;
    IncludeCharacters := KeyForm.EditIncludeCharacters.Text;
    PrintWidth := KeyForm.SpinEditPrintWidth.Value;
    case KeyForm.ComboBoxOutputFormat.ItemIndex of
      0: Extension := 'txt';
      1: Extension := 'htm';
      //2: Extension := 'rtf';
    end;
    CreateTOKEY('tokey', Dataset.Heading, UseNormalValues, CharacterReliabilities,
      KeyStates, IncludeItems, IncludeCharacters);
    {$IFDEF WINDOWS}
    ConforPath := sPath + 'confor.exe';
    {$ELSE}
    ConforPath := sPath + 'confor';
    {$ENDIF}
    if FileExists('key.' + Extension) then
      DeleteFile('key.' + Extension);
    Screen.Cursor := crHourGlass;
    if RunCommand(ConforPath, ['tokey'], S, [poNoConsole]) then
    begin
      CreateKEY('key', Dataset.Heading, AddCharacterNumbers, NoBrackettedKey,
        NoTabularKey, NumberOfConfirmatoryCharacters,
        TreatCharactersAsVariable, ABase, RBase, Reuse, Varywt, PrintWidth, Extension);
      {$IFDEF WINDOWS}
      KeyPath := sPath + 'key.exe';
      {$ELSE}
      KeyPath := sPath + 'key';
      {$ENDIF}
      if RunCommand(KeyPath, ['key'], S, [poNoConsole]) then
      begin
        FileIsChanged := True;
        SaveBtn.Enabled := True;
        Screen.Cursor := crDefault;
        with ViewerForm do
        begin
          Caption := 'key.' + Extension;
          ScrollBox.Visible := False;
          ImageViewer.Visible := False;
          if not FileExists('key.' + Extension) then
          begin
            Screen.Cursor := crDefault;
            MessageDlg(strError, Format(strNotExecute, ['DELTA KEY']),
              mtError, [mbOK], 0);
            ShowErrorLog(S);
          end
          else
          begin
            if (Extension = 'txt') then
            begin
              RtfViewer.Visible := False;
              HtmlViewer.Visible := False;
              TextViewer.Visible := True;
              TextViewer.Lines.LoadFromFile('key.' + Extension);
            end
            else if (Extension = 'htm') then
            begin
              RtfViewer.Visible := False;
              TextViewer.Visible := False;
              HtmlViewer.Visible := True;
              HtmlViewer.LoadFromFile('key.' + Extension);
            end;
            {else if (Extension = 'rtf') then
            begin
              RtfViewer.Visible := True;
              TextViewer.Visible := False;
              HtmlViewer.Visible := False;
              FS := TFileStream.Create(Utf8ToAnsi('key.' + Extension),
                fmOpenRead or fmShareDenyNone);
              try
                RtfViewer.LoadRichText(FS);
              finally
                FS.Free
              end;
            end;}
            Show;
          end;
        end;
      end
      else
      begin
        Screen.Cursor := crDefault;
        MessageDlg(strError, Format(strNotExecute, ['DELTA KEY']),
          mtError, [mbOK], 0);
        ShowErrorLog(S);
      end;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
      ShowErrorLog(S);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.KeyInteractiveItemClick(Sender: TObject);
var
  CharacterReliabilities, IncludeItems, IncludeCharacters: string;
  sPath, ConforPath, ImagePath, HlpFile, Lang
  {$IFDEF VER3}
  , DefaultLang
  {$ENDIF}
  : string;
  RBase, Varywt: double;
  s: ansistring;
begin
  sPath := ExtractFilePath(Application.ExeName);
  DefaultFormatSettings.DecimalSeparator := '.';
  if (IntKeyPath = '') or (not DirectoryExists(ExtractFileDir(IntKeyPath))) then
  begin
    SelectDirectoryDialog.Title := strDeltaDirectory;
    SelectDirectoryDialog.Filename := '';
    if SelectDirectoryDialog.Execute then
    begin
      {$IFDEF WINDOWS}
      IntKeyPath := SelectDirectoryDialog.FileName + '\Intkey.exe';
      {$ELSE}
      IntKeyPath := SelectDirectoryDialog.FileName + '/Intkey.sh';
      {$ENDIF}
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, strDirNotFound, mtError, [mbOK], 0);
      Exit;
    end;
  end;
  if FileExists('toint') then
  begin
    CharacterReliabilities :=
      Delta.ReadDirective('toint', '*CHARACTER RELIABILITIES', True);
    IncludeItems := Delta.ReadDirective('toint', '*INCLUDE ITEMS', True);
    IncludeCharacters := Delta.ReadDirective('toint', '*INCLUDE CHARACTERS', True);
  end
  else
  begin
    CharacterReliabilities := '';
    IncludeItems := '';
    IncludeCharacters := '';
  end;
  if FileExists('intkey.ink') then
  begin
    RBase := StrToFloatDef(Delta.ReadDirective('intkey.ink', '*RBASE', True), 1.1);
    Varywt := StrToFloatDef(Delta.ReadDirective('intkey.ink', '*VARYWT', True), 1.0);
    ImagePath := Delta.ReadDirective('intkey.ink', '*SET IMAGEPATH', True);
  end
  else
  begin
    RBase := 1.1;
    Varywt := 1.0;
    ImagePath := 'images';
  end;
  with IntKeyForm do
  begin
    EditHeading.Text := Dataset.Heading;
    EditCharacterReliabilities.Text := CharacterReliabilities;
    FloatSpinEditRBASE.Value := RBase;
    FloatSpinEditVARYWT.Value := Varywt;
    EditIncludeItems.Text := IncludeItems;
    EditIncludeCharacters.Text := IncludeCharacters;
    DirectoryEditImagePath.Text := ImagePath;
  end;
  if IntKeyForm.ShowModal = mrOk then
  begin
    CharacterReliabilities := IntKeyForm.EditCharacterReliabilities.Text;
    RBase := IntKeyForm.FloatSpinEditRBASE.Value;
    Varywt := IntKeyForm.FloatSpinEditVARYWT.Value;
    IncludeItems := IntKeyForm.EditIncludeItems.Text;
    IncludeCharacters := IntKeyForm.EditIncludeCharacters.Text;
    ImagePath := IntKeyForm.DirectoryEditImagePath.Text;
    CreateTOINT('toint', Dataset.Heading, CharacterReliabilities,
      IncludeItems, IncludeCharacters);
    {$IFDEF WINDOWS}
    ConforPath := sPath + 'confor.exe';
    {$ELSE}
    ConforPath := sPath + 'confor';
    {$ENDIF}
    Screen.Cursor := crHourGlass;
    if RunCommand(ConforPath, ['toint'], s, [poNoConsole]) then
    begin
      if not FileExists('intkey.ink') then
        CreateINTKEY('intkey.ink', Dataset.Heading, RBase, Varywt);
      if not FileExists('timages') then
        CreateTIMAGES('timages');
      if not FileExists('cimages') then
        CreateCIMAGES('cimages');
      {.$IFDEF VER3}
      {if DefaultLang = '' then
        SetDefaultLang('');
      Lang := DefaultLang;
      {.$ELSE}
      Lang := GetDefaultLang;
      {.$ENDIF}
      case Lang of
        'en': HlpFile := 'intken.hin';
        'pt': HlpFile := 'intkpt.hin';
        'fr': HlpFile := 'intkfr.hin';
        'es': HlpFile := 'intkes.hin';
        else
          HelpFile := 'intken.hin';
      end;}
      {if not RunCommand(IntKeyPath, ['-h=' + HlpFile, 'intkey.ink'],
        s, [poNoConsole]) then}
      if not RunCommand(IntKeyPath, ['intkey.ink'], s, [poNoConsole]) then
      begin
        FileIsChanged := True;
        SaveBtn.Enabled := True;
        Screen.Cursor := crDefault;
        MessageDlg(strError, Format(strNotExecute, ['DELTA INTKEY']),
          mtError, [mbOK], 0);
        IntKeyPath := '';
      end;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']),
        mtError, [mbOK], 0);
      ShowErrorLog(S);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.LanguageEnglishItemClick(Sender: TObject);
var
  sPath: string;
  IniFile: TIniFile;
begin
  sLang := 'en';
  LanguageEnglishItem.Checked := True;
  LanguagePortugueseItem.Checked := False;
  LanguageFrenchItem.Checked := False;
  LanguageSpanishItem.Checked := False;
  sPath := GetAppConfigDir(False);
  IniFile := TIniFile.Create(sPath + 'fde.ini');
  {$IFDEF VER3}
  SetDefaultLang(sLang, 'languages', '', True);
  {$ELSE}
  SetDefaultLang(sLang, 'languages', True);
  {$ENDIF}
  IniFile.WriteString('Options', 'Language', 'en');
  IniFile.Free;
end;

procedure TMainForm.LanguageFrenchItemClick(Sender: TObject);
var
  sPath: string;
  IniFile: TIniFile;
begin
  sLang := 'fr';
  LanguageFrenchItem.Checked := True;
  LanguagePortugueseItem.Checked := False;
  LanguageEnglishItem.Checked := False;
  LanguageSpanishItem.Checked := False;
  sPath := GetAppConfigDir(False);
  IniFile := TIniFile.Create(sPath + 'fde.ini');
  {$IFDEF VER3}
  SetDefaultLang(sLang, 'languages', '', True);
  {$ELSE}
  SetDefaultLang(sLang, 'languages', True);
  {$ENDIF}
  IniFile.WriteString('Options', 'Language', 'fr');
  IniFile.Free;
end;

procedure TMainForm.LanguagePortugueseItemClick(Sender: TObject);
var
  sPath: string;
  IniFile: TIniFile;
begin
  sLang := 'pt_br';
  LanguagePortugueseItem.Checked := True;
  LanguageEnglishItem.Checked := False;
  LanguageFrenchItem.Checked := False;
  LanguageSpanishItem.Checked := False;
  sPath := GetAppConfigDir(False);
  IniFile := TIniFile.Create(sPath + 'fde.ini');
  {$IFDEF VER3}
  SetDefaultLang(sLang, 'languages', '', True);
  {$ELSE}
  SetDefaultLang(sLang, 'languages', True);
  {$ENDIF}
  IniFile.WriteString('Options', 'Language', 'pt_br');
  IniFile.Free;
end;

procedure TMainForm.LanguageSpanishItemClick(Sender: TObject);
var
  sPath: string;
  IniFile: TIniFile;
begin
  sLang := 'es';
  LanguageSpanishItem.Checked := True;
  LanguageFrenchItem.Checked := False;
  LanguagePortugueseItem.Checked := False;
  LanguageEnglishItem.Checked := False;
  sPath := GetAppConfigDir(False);
  IniFile := TIniFile.Create(sPath + 'fde.ini');
  {$IFDEF VER3}
  SetDefaultLang(sLang, 'languages', '', True);
  {$ELSE}
  SetDefaultLang(sLang, 'languages', True);
  {$ENDIF}
  IniFile.WriteString('Options', 'Language', 'es');
  IniFile.Free;
end;

procedure TMainForm.MatrixClusterItemClick(Sender: TObject);
var
  s: ansistring;
  nex, notu: integer;
begin
  {if RPath = '' then
  begin
    SelectDirectoryDialog.Title := strRDirectory;
    SelectDirectoryDialog.Filename := '';
    if SelectDirectoryDialog.Execute then
      RPath := SelectDirectoryDialog.FileName
    else
    begin
      MessageDlg(strError, Format(strRNotFound, ['R']), mtError, [mbOK], 0);
      Exit;
    end;
  end;}
  if not LocateR then
    Exit;
  if ClusterForm.ShowModal = mrOk then
  begin
    if FileExists('dist') then
    begin
      nex := WordCount(Delta.ReadDirective('dist', '*EXCLUDE ITEMS', True),
        StdWordDelims);
      if nex = 0 then
        notu := Length(Dataset.ItemList)
      else
        notu := Abs(Length(Dataset.ItemList) - nex);
    end
    else
      notu := Length(Dataset.ItemList);
    CreateCluster('cluster.R', notu, ClusterForm.ComboBoxMethod.ItemIndex);
    Screen.Cursor := crHourGlass;
    //if RunCommand(Concat(RPath, PathDelim, 'Rscript'), ['--vanilla', 'cluster.R'],
    //  s, [poNoConsole]) then
    if RunCommand(RPath, ['--vanilla', 'cluster.R'], s, [poNoConsole]) then
    begin
      Screen.Cursor := crDefault;
      with ViewerForm do
      begin
        Caption := 'cluster.png';
        TextViewer.Visible := False;
        HtmlViewer.Visible := False;
        ScrollBox.Visible := True;
        ImageViewer.Visible := True;
        ImageViewer.Picture.LoadFromFile('cluster.png');
        Show;
      end;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, Format(strNotExecute, ['R']), mtError, [mbOK], 0);
      RPath := '';
    end;
  end;
end;

procedure TMainForm.MatrixDistanceItemClick(Sender: TObject);
var
  MatchOverlap: boolean;
  NC, MinimumComparisons: integer;
  PhylipFormat: boolean;
  ExcludeItems, ExcludeCharacters, sPath, ConforPath, DistPath, aname: string;
  S: ansistring;
  inf, outf: TextFile;
begin
  sPath := ExtractFilePath(Application.ExeName);
  nc := Trunc(Sqrt(Length(Dataset.CharacterList)));
  if FileExists('dist') then
  begin
    if Delta.ReadDirective('dist', '*MATCH OVERLAP') = '' then
      MatchOverlap := False
    else
      MatchOverlap := True;
    MinimumComparisons := StrToIntDef(Delta.ReadDirective('dist',
      '*MINIMUM NUMBER OF COMPARISONS', True), nc);
    if Delta.ReadDirective('dist', '*PHYLIP FORMAT') = '' then
      PHYLIPFormat := False
    else
      PHYLIPFormat := True;
    ExcludeItems := Delta.ReadDirective('dist', '*EXCLUDE ITEMS', True);
    ExcludeCharacters := Delta.ReadDirective('dist', '*EXCLUDE CHARACTERS', True);
  end
  else
  begin
    MatchOverlap := False;
    MinimumComparisons := nc;
    PHYLIPFormat := False;
    ExcludeItems := '';
    ExcludeCharacters := '';
  end;
  with DistForm do
  begin
    CheckBoxMatchOverlap.Checked := MatchOverlap;
    SpinEditMinimumNumberOfComparisons.Value := MinimumComparisons;
    CheckBoxPHYLIPFormat.Checked := PHYLIPFormat;
    EditExcludeItems.Text := ExcludeItems;
    EditExcludeCharacters.Text := ExcludeCharacters;
  end;
  if DistForm.ShowModal = mrOk then
  begin
    MatchOverlap := DistForm.CheckBoxMatchOverlap.Checked;
    MinimumComparisons := DistForm.SpinEditMinimumNumberOfComparisons.Value;
    PhylipFormat := DistForm.CheckBoxPHYLIPFormat.Checked;
    ExcludeItems := DistForm.EditExcludeItems.Text;
    ExcludeCharacters := DistForm.EditExcludeCharacters.Text;
    CreateTODIS('todis', Dataset.Heading);
    {$IFDEF WINDOWS}
    ConforPath := sPath + 'confor.exe';
    {$ELSE}
    ConforPath := sPath + 'confor';
    {$ENDIF}
    if FileExists('dist.nam') then
      DeleteFile('dist.name');
    if FileExists('dist.dis') then
      DeleteFile('dist.dis');
    Screen.Cursor := crHourGlass;
    if RunCommand(ConforPath, ['todis'], S, [poNoConsole]) then
    begin
      CreateDIST('dist', MatchOverlap, MinimumComparisons, PhylipFormat,
        ExcludeItems, ExcludeCharacters);
      {$IFDEF WINDOWS}
      DistPath := sPath + 'dist.exe';
      {$ELSE}
      DistPath := sPath + 'dist';
      {$ENDIF}
      if RunCommand(DistPath, ['dist'], S, [poNoConsole]) then
      begin
        FileIsChanged := True;
        SaveBtn.Enabled := True;
        Screen.Cursor := crDefault;
        hasDistance := True;
        UpdateMenuItems(self);
        with ViewerForm do
        begin
          Caption := 'dist.dis';
          ScrollBox.Visible := False;
          ImageViewer.Visible := False;
          TextViewer.Visible := True;
          TextViewer.Lines.LoadFromFile('dist.dis');
          Show;
        end;
        AssignFile(inf, 'dist.nam');
        Reset(inf);
        AssignFile(outf, 'temp.nam');
        Rewrite(outf);
        while not EOF(inf) do
        begin
          ReadLn(inf, aname);
          WriteLn(outf, ReplaceStr(aname, ' ', '_'));
        end;
        CloseFile(inf);
        CloseFile(outf);
        DeleteFile('dist.nam');
        RenameFile('temp.nam', 'dist.nam');
      end
      else
      begin
        Screen.Cursor := crDefault;
        MessageDlg(strError, Format(strNotExecute, ['DELTA DIST']),
          mtError, [mbOK], 0);
        ShowErrorLog(S);
      end;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
      ShowErrorLog(S);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.MatrixOrdinationItemClick(Sender: TObject);
var
  S: ansistring;
  nex, notu: integer;
begin
  {if RPath = '' then
  begin
    SelectDirectoryDialog.Title := strRDirectory;
    SelectDirectoryDialog.Filename := '';
    if SelectDirectoryDialog.Execute then
      RPath := SelectDirectoryDialog.FileName
    else
    begin
      MessageDlg(strError, Format(strRNotFound, ['R']), mtError, [mbOK], 0);
      Exit;
    end;
  end;}
  if not LocateR then
    Exit;
  if FileExists('dist') then
  begin
    nex := WordCount(Delta.ReadDirective('dist', '*EXCLUDE ITEMS', True),
      StdWordDelims);
    if nex = 0 then
      notu := Length(Dataset.ItemList)
    else
      notu := Abs(Length(Dataset.ItemList) - nex);
  end
  else
    notu := Length(Dataset.ItemList);
  CreatePCOA('pcoa.R', notu);
  Screen.Cursor := crHourGlass;
  //if RunCommand(Concat(RPath, PathDelim, 'Rscript'), ['--vanilla', 'pcoa.R'],
  //  S, [poNoConsole]) then
  if RunCommand(RPath, ['--vanilla', 'pcoa.R'], S, [poNoConsole]) then
  begin
    Screen.Cursor := crDefault;
    with ViewerForm do
    begin
      Caption := 'pcoa.png';
      TextViewer.Visible := False;
      HtmlViewer.Visible := False;
      ScrollBox.Visible := True;
      ImageViewer.Visible := True;
      ImageViewer.Picture.LoadFromFile('pcoa.png');
      Show;
    end;
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg(strError, Format(strNotExecute, ['R']), mtError, [mbOK], 0);
    RPath := '';
  end;
end;

procedure TMainForm.MatrixParsimonyItemPAUPClick(Sender: TObject);
var
  KeyStates, ExcludeItems, ExcludeCharacters: string;
  S, sPath, ConforPath, CmdLine, Datafile: ansistring;
  {$IFDEF LINUX}
  ShellProg: ansistring;
  {$ENDIF}
  AProcess: TProcess;
begin
  if (not IsWindows) and Is32Bit then
  begin
    MessageDlg(strLinux64Only, mtInformation, [mbOK], 0);
    Exit;
  end;
  sPath := ExtractFilePath(Application.ExeName);
  with Sender as TMenuItem do
    Checked := True;
  if PAUPPath = '' then
  begin
    SelectDirectoryDialog.Title := strPAUPDirectory;
    SelectDirectoryDialog.Filename := '';
    if SelectDirectoryDialog.Execute then
      PAUPPath := SelectDirectoryDialog.FileName
    else
    begin
      MessageDlg(strError, Format(strPAUPNotFound, ['PAUP']), mtError, [mbOK], 0);
      Exit;
    end;
  end;
  //Datafile := Concat(LowerCase(GetFileNameWithoutExt(OpenDialog.Filename)), '.nex');
  Datafile := Concat(LowerCase(GetFileNameWithoutExt(OpenDialog.Filename)), '.tnt');
  //if FileExists('tonex') then
  if FileExists('tohen') then
  begin
    KeyStates := Delta.ReadDirective('tonex', '*KEY STATES', True);
    ExcludeItems := Delta.ReadDirective('tonex', '*EXCLUDE ITEMS', True);
    ExcludeCharacters := Delta.ReadDirective('tonex', '*EXCLUDE CHARACTERS', True);
  end
  else
  begin
    KeyStates := '';
    ExcludeItems := '';
    ExcludeCharacters := '';
  end;
  with PhyloForm do
  begin
    EditKeyStates.Text := KeyStates;
    EditExcludeItems.Text := ExcludeItems;
    EditExcludeCharacters.Text := ExcludeCharacters;
  end;
  if PhyloForm.ShowModal = mrOk then
  begin
    KeyStates := PhyloForm.EditKeyStates.Text;
    ExcludeItems := PhyloForm.EditExcludeItems.Text;
    ExcludeCharacters := PhyloForm.EditExcludeCharacters.Text;
    //CreateTONEX('tonex', Dataset.Heading, KeyStates, ExcludeItems,
    //  ExcludeCharacters, Datafile);
    CreateTOHEN('tohen', Dataset.Heading, KeyStates, ExcludeItems,
      ExcludeCharacters, Datafile);
    {$IFDEF WINDOWS}
    ConforPath := sPath + 'confor.exe';
    CmdLine := 'paup4c';
    {$ELSE}
    ConforPath := sPath + 'confor';
    CmdLine := 'paup4a168_ubuntu64';
    ShellProg := DetectXTerm;
    {$ENDIF}
    Screen.Cursor := crHourGlass;
    //if RunCommand(ConforPath, ['tonex'], S, [poNoConsole]) then
    if RunCommand(ConforPath, ['tohen'], S, [poNoConsole]) then
    begin
      FileIsChanged := True;
      SaveBtn.Enabled := True;
      ToNex(Datafile);
      Datafile := Concat(GetFileNameWithoutExt(Datafile), '.nex');
      MessageDlg(strInformation, Format(strExportFile, [ExpandFileName(Datafile)]),
        mtInformation, [mbOK], 0);
      AProcess := TProcess.Create(nil);
      try
        {$IFDEF WINDOWS}
        AProcess.Executable := Concat(PAUPPath, PathDelim, CmdLine);
        {$ELSE}
        AProcess.Executable := ShellProg;
        AProcess.Parameters.Add('-e');
        AProcess.Parameters.Add(Concat(PAUPPath, PathDelim, CmdLine));
        {$ENDIF}
        AProcess.Parameters.Add(Datafile);
        AProcess.Options := AProcess.Options + [poWaitOnExit];
        AProcess.Execute;
        if AProcess.ExitCode <> 0 then
        begin
          MessageDlg(strError, Format(strNotExecute, ['PAUP']), mtError, [mbOK], 0);
          PAUPPath := '';
        end;
      finally
        AProcess.Free;
      end;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
      ShowErrorLog(S);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.MatrixParsimonyItemTNTClick(Sender: TObject);
var
  KeyStates, ExcludeItems, ExcludeCharacters: string;
  S, sPath, ConforPath, CmdLine, Datafile: ansistring;
  {$IFDEF LINUX}
  ShellProg: ansistring;
  {$ENDIF}
  AProcess: TProcess;
begin
  if (not IsWindows) and Is32Bit then
  begin
    MessageDlg(strLinux64Only, mtInformation, [mbOK], 0);
    Exit;
  end;
  sPath := ExtractFilePath(Application.ExeName);
  with Sender as TMenuItem do
    Checked := True;
  if TNTPath = '' then
  begin
    SelectDirectoryDialog.Title := strTNTDirectory;
    SelectDirectoryDialog.Filename := '';
    if SelectDirectoryDialog.Execute then
      TNTPath := SelectDirectoryDialog.FileName
    else
    begin
      MessageDlg(strError, Format(strTNTNotFound, ['TNT']), mtError, [mbOK], 0);
      Exit;
    end;
  end;
  Datafile := Concat(LowerCase(GetFileNameWithoutExt(OpenDialog.Filename)), '.tnt');
  if FileExists('tohen') then
  begin
    KeyStates := Delta.ReadDirective('tohen', '*KEY STATES', True);
    ExcludeItems := Delta.ReadDirective('tohen', '*EXCLUDE ITEMS', True);
    ExcludeCharacters := Delta.ReadDirective('tohen', '*EXCLUDE CHARACTERS', True);
  end
  else
  begin
    KeyStates := '';
    ExcludeItems := '';
    ExcludeCharacters := '';
  end;
  with PhyloForm do
  begin
    EditKeyStates.Text := KeyStates;
    EditExcludeItems.Text := ExcludeItems;
    EditExcludeCharacters.Text := ExcludeCharacters;
  end;
  if PhyloForm.ShowModal = mrOk then
  begin
    KeyStates := PhyloForm.EditKeyStates.Text;
    ExcludeItems := PhyloForm.EditExcludeItems.Text;
    ExcludeCharacters := PhyloForm.EditExcludeCharacters.Text;
    CreateTOHEN('tohen', Dataset.Heading, KeyStates, ExcludeItems,
      ExcludeCharacters, Datafile);
    {$IFDEF WINDOWS}
    ConforPath := sPath + 'confor.exe';
    {$ELSE}
    ConforPath := sPath + 'confor';
    {$ENDIF}
    Screen.Cursor := crHourGlass;
    if RunCommand(ConforPath, ['tohen'], S, [poNoConsole]) then
    begin
      FileIsChanged := True;
      SaveBtn.Enabled := True;
      MessageDlg(strInformation, Format(strExportFile, [ExpandFileName(Datafile)]),
        mtInformation, [mbOK], 0);
      AProcess := TProcess.Create(nil);
      try
        {$IFDEF WINDOWS}
        AProcess.Executable := Concat(TNTPath, PathDelim, 'tnt');
        AProcess.Parameters.Add(Datafile);
        {$ELSE}
        ShellProg := DetectXTerm;
        CmdLine := Concat(TNTPath, PathDelim, 'tnt');
        AProcess.Executable := ShellProg;
        AProcess.Parameters.Add('-e');
        AProcess.Parameters.Add(CmdLine);
        AProcess.Parameters.Add('p ' + Datafile);
        {$ENDIF}
        AProcess.Options := AProcess.Options + [poWaitOnExit];
        AProcess.Execute;
        if AProcess.ExitCode <> 0 then
        begin
          MessageDlg(strError, Format(strNotExecute, ['TNT']), mtError, [mbOK], 0);
          TNTPath := '';
        end;
      finally
        AProcess.Free;
      end;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
      ShowErrorLog(S);
    end;
    Screen.Cursor := crDefault;
  end;
end;

procedure TMainForm.MoveCharacterDownClick(Sender: TObject);
var
  Selected: TListItem;
  CharStr: string;
  I, J: integer;
begin
  Selected := CharacterListView.Selected;
  if Assigned(Selected) then
    if Selected.Index + 1 < CharacterListView.Items.Count then
    begin
      ExchangeCharacters(Selected.Index, Selected.Index + 1);
      for I := 0 to Length(Dataset.ItemList) - 1 do
        Dataset.ItemList[I].itemAttributes.Exchange(Selected.Index, Selected.Index + 1);
    end
    else
      Exit;
  if PageControl.TabIndex = 0 then
    CharacterListView.SetFocus;
  for J := 0 to CharacterListView.Items.Count - 1 do
  begin
    CharStr := Copy(CharacterListView.Items[J].Caption,
      Pos('.', CharacterListView.Items[J].Caption) + 1,
      Length(CharacterListView.Items[J].Caption));
    CharacterListView.Items[J].Caption := IntToStr(J + 1) + '. ' + CharStr;
  end;
  LoadMatrix;
  FileIsChanged := True;
  SaveBtn.Enabled := True;
  UpdateTitleBar(OpenDialog.FileName);
end;

procedure TMainForm.MoveCharacterUpClick(Sender: TObject);
var
  Selected: TListItem;
  CharStr: string;
  I, J: integer;
begin
  Selected := CharacterListView.Selected;
  if Assigned(Selected) then
    if Selected.Index - 1 >= 0 then
    begin
      ExchangeCharacters(Selected.Index, Selected.Index - 1);
      for I := 0 to Length(Dataset.ItemList) - 1 do
        Dataset.ItemList[I].itemAttributes.Exchange(Selected.Index, Selected.Index - 1);
    end
    else
      Exit;
  if PageControl.TabIndex = 0 then
    CharacterListView.SetFocus;
  for J := 0 to CharacterListView.Items.Count - 1 do
  begin
    CharStr := Copy(CharacterListView.Items[J].Caption,
      Pos('.', CharacterListView.Items[J].Caption) + 1,
      Length(CharacterListView.Items[J].Caption));
    CharacterListView.Items[J].Caption := IntToStr(J + 1) + '. ' + CharStr;
  end;
  LoadMatrix;
  FileIsChanged := True;
  SaveBtn.Enabled := True;
  UpdateTitleBar(OpenDialog.FileName);
end;

procedure TMainForm.MoveItemDownClick(Sender: TObject);
var
  Selected: TListItem;
  ItemStr: string;
  I: integer;
begin
  Selected := ItemListView.Selected;
  if Assigned(Selected) then
    if Selected.Index + 1 < ItemListView.Items.Count then
      ExchangeItems(Selected.Index, Selected.Index + 1)
    else
      Exit;
  if PageControl.TabIndex = 0 then
    ItemListView.SetFocus;
  for I := 0 to ItemListView.Items.Count - 1 do
  begin
    ItemStr := Copy(ItemListView.Items[I].Caption,
      Pos('.', ItemListView.Items[I].Caption) + 1,
      Length(ItemListView.Items[I].Caption));
    ItemListView.Items[I].Caption := IntToStr(I + 1) + '. ' + ItemStr;
  end;
  LoadMatrix;
  FileIsChanged := True;
  SaveBtn.Enabled := True;
  UpdateTitleBar(OpenDialog.FileName);
end;

procedure TMainForm.MoveItemUpClick(Sender: TObject);
var
  Selected: TListItem;
  ItemStr: string;
  I: integer;
begin
  Selected := ItemListView.Selected;
  if Assigned(Selected) then
    if Selected.Index - 1 >= 0 then
      ExchangeItems(Selected.Index, Selected.Index - 1)
    else
      Exit;
  if PageControl.TabIndex = 0 then
    ItemListView.SetFocus;
  for I := 0 to ItemListView.Items.Count - 1 do
  begin
    ItemStr := Copy(ItemListView.Items[I].Caption,
      Pos('.', ItemListView.Items[I].Caption) + 1,
      Length(ItemListView.Items[I].Caption));
    ItemListView.Items[I].Caption := IntToStr(I + 1) + '. ' + ItemStr;
  end;
  LoadMatrix;
  FileIsChanged := True;
  SaveBtn.Enabled := True;
  UpdateTitleBar(OpenDialog.FileName);
end;

procedure TMainForm.PageControlChange(Sender: TObject);
var
  ARow, ACol: integer;
  CanSelect: boolean;
begin
  if PageControl.ActivePage = ListTab then
  begin
    ARow := DataMatrix.Row;
    ItemListView.ItemIndex := ARow - 1;
    ItemListView.Selected;
    ItemListView.SetFocus;
  end;
  if PageControl.ActivePage = MatrixTab then
  begin
    if ItemListView.Selected <> nil then
      ARow := ItemListView.Selected.Index + 1
    else
      ARow := 1;
    if CharacterListView.Selected <> nil then
      ACol := CharacterListView.Selected.Index + 1
    else
      ACol := 1;
    DataMatrix.Row := ARow;
    DataMatrix.Col := ACol;
    DataMatrixSelectCell(Self, ACol, ARow, CanSelect);
    DataMatrix.Refresh;
    DataMatrix.SetFocus;
  end;
end;

procedure TMainForm.PrepareSummaryItemClick(Sender: TObject);
var
  S, sPath, ConforPath: string;
begin
  sPath := ExtractFilePath(Application.ExeName);
  CreateSUMMARY('summary', Dataset.Heading);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if FileExists('summary.txt') then
    DeleteFile('summary.txt');
  Screen.Cursor := crHourGlass;
  if RunCommand(ConforPath, ['summary'], S, [poNoConsole]) then
  begin
    FileIsChanged := True;
    SaveBtn.Enabled := True;
    Screen.Cursor := crDefault;
    with ViewerForm do
    begin
      Caption := 'summary.txt';
      ScrollBox.Visible := False;
      ImageViewer.Visible := False;
      TextViewer.Visible := True;
      TextViewer.Lines.LoadFromFile('summary.txt');
      Show;
    end;
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
    ShowErrorLog(S);
  end;
  Screen.Cursor := crDefault;
end;

procedure TMainForm.PrepareTonatItemClick(Sender: TObject);
var
  ReplaceAngleBrackets, OmitCharacterNumbers, OmitInapplicables,
  OmitComments, OmitInnerComments, OmitFinalComma, OmitTypesettingMarks,
  TranslateImplicitValues: boolean;
  OmitLowerForCharacters, OmitOrForCharacters, OmitPeriodForCharacters,
  NewParagraphsAtCharacters, EmphasizeFeatures, ItemSubheadings,
  LinkCharacters, ReplaceSemicolonByComma, ExcludeItems, ExcludeCharacters,
  Lang, sPath, ConforPath, Extension
  {$IFDEF VER3}
  , DefaultLang
  {$ENDIF}
  : string;
  PrintWidth: integer;
  S: ansistring;
  Vocabulary: TStringList;
  FS: TFileStream;
begin
  sPath := ExtractFilePath(Application.ExeName);
  Vocabulary := TStringList.Create;
  GetLanguageIDs(Lang, DefaultLang);
  case Lang of
    'en': Vocabulary.LoadFromFile(sPath + 'vocabulary/vocaben');
    'pt': Vocabulary.LoadFromFile(sPath + 'vocabulary/vocabpt');
    'fr': Vocabulary.LoadFromFile(sPath + 'vocabulary/vocabfr');
    'es': Vocabulary.LoadFromFile(sPath + 'vocabulary/vocabes');
    else
      Vocabulary.LoadFromFile(sPath + 'vocabulary/vocaben');
  end;
  if FileExists('tonat') then
  begin
    if Delta.ReadDirective('tonat', '*REPLACE ANGLE BRACKETS') = '' then
      ReplaceAngleBrackets := False
    else
      ReplaceAngleBrackets := True;
    if Delta.ReadDirective('tonat', '*OMIT CHARACTER NUMBERS') = '' then
      OmitCharacterNumbers := False
    else
      OmitCharacterNumbers := True;
    if Delta.ReadDirective('tonat', '*OMIT INAPPLICABLES') = '' then
      OmitInapplicables := False
    else
      OmitInapplicables := True;
    if Delta.ReadDirective('tonat', '*OMIT COMMENTS') = '' then
      OmitComments := False
    else
      OmitComments := True;
    if Delta.ReadDirective('tonat', '*OMIT INNER COMMENTS') = '' then
      OmitInnerComments := False
    else
      OmitInnerComments := True;
    if Delta.ReadDirective('tonat', '*OMIT FINAL COMMA') = '' then
      OmitFinalComma := False
    else
      OmitFinalComma := True;
    if Delta.ReadDirective('tonat', '*OMIT TYPESETTING MARKS') = '' then
      OmitTypesettingMarks := False
    else
      OmitTypesettingMarks := True;
    if Delta.ReadDirective('tonat', '*TRANSLATE IMPLICIT VALUES') = '' then
      TranslateImplicitValues := False
    else
      TranslateImplicitValues := True;
    OmitLowerForCharacters := Delta.ReadDirective('tonat',
      '*OMIT LOWER FOR CHARACTERS', True);
    OmitOrForCharacters := Delta.ReadDirective('tonat', '*OMIT OR FOR CHARACTERS', True);
    OmitPeriodForCharacters :=
      Delta.ReadDirective('tonat', '*OMIT PERIOD FOR CHARACTERS', True);
    NewParagraphsAtCharacters :=
      Delta.ReadDirective('tonat', '*NEW PARAGRAPHS AT CHARACTERS', True);
    EmphasizeFeatures := Delta.ReadDirective('tonat', '*EMPHASIZE FEATURES', True);
    ItemSubheadings := Delta.GetSubHeadings('tonat');
    LinkCharacters := Delta.ReadDirective('tonat', '*LINK CHARACTERS', True);
    ReplaceSemicolonByComma :=
      Delta.ReadDirective('tonat', '*REPLACE SEMICOLON BY COMMA', True);
    ExcludeItems := Delta.ReadDirective('tonat', '*EXCLUDE ITEMS', True);
    ExcludeCharacters := Delta.ReadDirective('tonat', '*EXCLUDE CHARACTERS', True);
    PrintWidth := StrToIntDef(Delta.ReadDirective('tonat', '*PRINT WIDTH', True), 80);
  end
  else
  begin
    ReplaceAngleBrackets := True;
    OmitCharacterNumbers := True;
    OmitInapplicables := True;
    OmitComments := True;
    OmitInnerComments := True;
    OmitFinalComma := True;
    OmitTypesettingMarks := True;
    TranslateImplicitValues := False;
    OmitLowerForCharacters := '';
    OmitOrForCharacters := '';
    OmitPeriodForCharacters := '';
    NewParagraphsAtCharacters := '';
    EmphasizeFeatures := '';
    ItemSubheadings := '';
    LinkCharacters := '';
    ReplaceSemicolonByComma := '';
    ExcludeItems := '';
    ExcludeCharacters := '';
    PrintWidth := 80;
  end;
  with TonatForm do
  begin
    EditHeading.Text := Dataset.Heading;
    CheckBoxReplaceAngleBrackets.Checked := ReplaceAngleBrackets;
    CheckBoxOmitCharacterNumbers.Checked := OmitCharacterNumbers;
    CheckBoxOmitInapplicables.Checked := OmitInapplicables;
    CheckBoxOmitComments.Checked := OmitComments;
    CheckBoxOmitInnerComments.Checked := OmitInnerComments;
    CheckBoxOmitFinalComma.Checked := OmitFinalComma;
    CheckBoxTranslateImplicitValues.Checked := TranslateImplicitValues;
    CheckBoxOmitTypesettingMarks.Checked := OmitTypesettingMarks;
    EditOmitLowerForCharacters.Text := OmitLowerForCharacters;
    EditOmitOrForCharacters.Text := OmitOrForCharacters;
    EditOmitPeriodForCharacters.Text := OmitPeriodForCharacters;
    EditNewParagraphsAtCharacters.Text := NewParagraphsAtCharacters;
    EditEmphasizeFeatures.Text := EmphasizeFeatures;
    EditItemSubheadings.Text := ItemSubheadings;
    EditLinkCharacters.Text := LinkCharacters;
    EditReplaceSemicolonByComma.Text := ReplaceSemicolonByComma;
    EditExcludeItems.Text := ExcludeItems;
    EditExcludeCharacters.Text := ExcludeCharacters;
    SpinEditPrintWidth.Value := PrintWidth;
  end;
  if TonatForm.ShowModal = mrOk then
  begin
    ReplaceAngleBrackets := TonatForm.CheckBoxReplaceAngleBrackets.Checked;
    OmitCharacterNumbers := TonatForm.CheckBoxOmitCharacterNumbers.Checked;
    OmitInapplicables := TonatForm.CheckBoxOmitInapplicables.Checked;
    OmitComments := TonatForm.CheckBoxOmitComments.Checked;
    OmitInnerComments := TonatForm.CheckBoxOmitInnerComments.Checked;
    OmitFinalComma := TOnatForm.CheckBoxOmitFinalComma.Checked;
    OmitTypesettingMarks := TonatForm.CheckBoxOmitTypesettingMarks.Checked;
    OmitLowerForCharacters := TonatForm.EditOmitLowerForCharacters.Text;
    OmitOrForCharacters := TonatForm.EditOmitOrForCharacters.Text;
    OmitPeriodForCharacters := TonatForm.EditOmitPeriodForCharacters.Text;
    TranslateImplicitValues := TonatForm.CheckBoxTranslateImplicitValues.Checked;
    NewParagraphsAtCharacters := TonatForm.EditNewParagraphsAtCharacters.Text;
    EmphasizeFeatures := TonatForm.EditEmphasizeFeatures.Text;
    ItemSubheadings := TonatForm.EditItemSubheadings.Text;
    LinkCharacters := TonatForm.EditLinkCharacters.Text;
    ReplaceSemicolonByComma := TonatForm.EditReplaceSemicolonByComma.Text;
    ExcludeItems := TonatForm.EditExcludeItems.Text;
    ExcludeCharacters := TonatForm.EditExcludeCharacters.Text;
    PrintWidth := TonatForm.SpinEditPrintWidth.Value;
    case TonatForm.ComboBoxOutputFormat.ItemIndex of
      0: Extension := 'txt';
      1: Extension := 'htm';
      2: Extension := 'rtf';
    end;
    //if OmitTypesettingMarks then
    //  OmitTypesettingMarks := False
    //else
    //if not OmitTypesettingMarks then
    //  OmitTypeSettingMarks := True;
    CreateTONAT('tonat', Dataset.Heading, ReplaceAngleBrackets,
      OmitCharacterNumbers,
      OmitInapplicables, OmitComments, OmitInnerComments, OmitFinalComma,
      OmitTypesettingMarks, TranslateImplicitValues,
      OmitLowerForCharacters, OmitOrForCharacters, OmitPeriodForCharacters,
      NewParagraphsAtCharacters, EmphasizeFeatures,
      ItemSubheadings, LinkCharacters, ReplaceSemicolonByComma,
      ExcludeItems, ExcludeCharacters, Vocabulary, PrintWidth, Extension);
    {$IFDEF WINDOWS}
    ConforPath := sPath + 'confor.exe';
    {$ELSE}
    ConforPath := sPath + 'confor';
    {$ENDIF}
    if FileExists('description.' + Extension) then
      DeleteFile('description.' + Extension);
    Screen.Cursor := crHourGlass;
    if RunCommand(ConforPath, ['tonat'], S, [poNoConsole]) then
    begin
      FileIsChanged := True;
      SaveBtn.Enabled := True;
      Screen.Cursor := crDefault;
      with ViewerForm do
      begin
        Caption := 'description.' + Extension;
        ScrollBox.Visible := False;
        ImageViewer.Visible := False;
        if (Extension = 'txt') then
        begin
          RtfViewer.Visible := False;
          HtmlViewer.Visible := False;
          TextViewer.Visible := True;
          TextViewer.Lines.LoadFromFile('description.' + Extension);
        end
        else if (Extension = 'htm') then
        begin
          RtfViewer.Visible := False;
          TextViewer.Visible := False;
          HtmlViewer.Visible := True;
          HtmlViewer.LoadFromFile('description.' + Extension);
        end
        else if (Extension = 'rtf') then
        begin
          RtfViewer.Visible := True;
          TextViewer.Visible := False;
          HtmlViewer.Visible := False;
          FS := TFileStream.Create(Utf8ToAnsi('description.' + Extension),
            fmOpenRead or fmShareDenyNone);
          try
            RtfViewer.LoadRichText(FS);
          finally
            FS.Free
          end;
        end;
        Show;
      end;
    end
    else
    begin
      Screen.Cursor := crDefault;
      MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']),
        mtError, [mbOK], 0);
      ShowErrorLog(S);
    end;
  end;
  Vocabulary.Free;
end;

procedure TMainForm.PrepareUncodedItemClick(Sender: TObject);
var
  S, sPath, ConforPath: string;
begin
  sPath := ExtractFilePath(Application.ExeName);
  CreateUNCODED('uncoded', Dataset.Heading);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if FileExists('uncoded.txt') then
    DeleteFile('uncoded.txt');
  Screen.Cursor := crHourGlass;
  if RunCommand(ConforPath, ['uncoded'], S, [poNoConsole]) then
  begin
    FileIsChanged := True;
    SaveBtn.Enabled := True;
    Screen.Cursor := crDefault;
    with ViewerForm do
    begin
      Caption := 'uncoded.txt';
      ScrollBox.Visible := False;
      ImageViewer.Visible := False;
      TextViewer.Visible := True;
      TextViewer.Lines.LoadFromFile('uncoded.txt');
      Show;
    end;
  end
  else
  begin
    Screen.Cursor := crDefault;
    MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']), mtError, [mbOK], 0);
    ShowErrorLog(S);
  end;
  Screen.Cursor := crDefault;
end;

procedure TMainForm.PrintCharactersItemClick(Sender: TObject);
var
  sPath, ConforPath: string;
  S: ansistring;
begin
  sPath := ExtractFilePath(Application.ExeName);
  CreatePRINTC('printc', Dataset.Heading);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if FileExists('characters.txt') then
    DeleteFile('characters.txt');
  if RunCommand(ConforPath, ['printc'], S, [poNoConsole]) then
  begin
    with ViewerForm do
    begin
      Caption := 'characters.txt';
      ScrollBox.Visible := False;
      ImageViewer.Visible := False;
      HtmlViewer.Visible := False;
      TextViewer.Lines.LoadFromFile('characters.txt');
      Show;
    end;
  end
  else
  begin
    MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']),
      mtError, [mbOK], 0);
    ShowErrorLog(S);
  end;
end;

procedure TMainForm.PrintItemsItemClick(Sender: TObject);
var
  sPath, ConforPath: string;
  S: ansistring;
begin
  sPath := ExtractFilePath(Application.ExeName);
  CreatePRINTI('printi', Dataset.Heading);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if FileExists('items.txt') then
    DeleteFile('items.txt');
  if RunCommand(ConforPath, ['printi'], S, [poNoConsole]) then
  begin
    with ViewerForm do
    begin
      Caption := 'items.txt';
      ScrollBox.Visible := False;
      ImageViewer.Visible := False;
      HtmlViewer.Visible := False;
      TextViewer.Lines.LoadFromFile('items.txt');
      Show;
    end;
  end
  else
  begin
    MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']),
      mtError, [mbOK], 0);
    ShowErrorLog(S);
  end;
end;

procedure TMainForm.PrintNamesItemClick(Sender: TObject);
var
  sPath, ConforPath: string;
  S: ansistring;
begin
  sPath := ExtractFilePath(Application.ExeName);
  CreatePRINTN('printn', Dataset.Heading);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if FileExists('names.txt') then
    DeleteFile('names.txt');
  if RunCommand(ConforPath, ['printn'], S, [poNoConsole]) then
  begin
    with ViewerForm do
    begin
      Caption := 'names.txt';
      ScrollBox.Visible := False;
      ImageViewer.Visible := False;
      HtmlViewer.Visible := False;
      TextViewer.Lines.LoadFromFile('names.txt');
      Show;
    end;
  end
  else
  begin
    MessageDlg(strError, Format(strNotExecute, ['DELTA CONFOR']),
      mtError, [mbOK], 0);
    ShowErrorLog(S);
  end;
end;

procedure TMainForm.SearchFindItemClick(Sender: TObject);
begin
  if ItemListView.Focused then
    FoundPos := ItemListView.Selected.Index
  else if CharacterListView.Focused then
    FoundPos := CharacterListView.Selected.Index
  else if DataMatrix.Focused then
    FoundPos := DataMatrix.Row
  else
    FoundPos := 0;
  FindDialog.Execute;
end;

procedure TMainForm.SearchFindNextItemClick(Sender: TObject);
begin
  if FindDialog.FindText = '' then
    SearchFindItemClick(Sender)
  else
    FindDialogFind(Sender);
end;

procedure TMainForm.SearchGotoLineClick(Sender: TObject);
var
  linenumber: integer;
begin
  linenumber := StrToIntDef(InputBox(strGotoLine, strGotoLineCaption, '1'), 1);
  if ItemListView.Focused then
  begin
    if (linenumber = 0) or (linenumber > Length(Dataset.ItemList)) then
      MessageDlg(strInformation, strOutOfRange, mtInformation, [mbOK], 0)
    else
      ItemListView.ItemIndex := linenumber - 1;
  end
  else if CharacterListView.Focused then
  begin
    if (linenumber = 0) or (linenumber > Length(Dataset.CharacterList)) then
      MessageDlg(strInformation, strOutOfRange, mtInformation, [mbOK], 0)
    else
      CharacterListView.ItemIndex := linenumber - 1;
  end
  else if DataMatrix.Focused then
  begin
    if (linenumber = 0) or (linenumber > Length(Dataset.ItemList)) then
      MessageDlg(strInformation, strOutOfRange, mtInformation, [mbOK], 0)
    else
      DataMatrix.Row := linenumber;
  end;
end;

procedure TMainForm.StatesListBoxItemClick(Sender: TObject; Index: integer);
begin
  StatesListBox.Checked[Index] := not (StatesListBox.Checked[Index]);
end;

procedure TMainForm.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FileNewItemClick(Sender: TObject);
var
  title: string;
begin
  if FileIsOpen then
    FileCloseItemClick(Self);
  title := InputBox(strNewCaption, strNewPrompt, strUntitled);
  Dataset.Free;
  Dataset := TDelta.Create;
  if (title = '') then
    Dataset.Heading := strUntitled;
  OpenDialog.FileName := strUntitled; //'';
  SaveDialog.FileName := strUntitled; //'';
  PageControl.Visible := True;
  PageControl.ActivePage := ListTab;
  ItemListView.Items.Clear;
  CharacterListView.Items.Clear;
  DataMatrix.Clean;
  DataMatrix.RowCount := 1;
  DataMatrix.ColCount := 1;
  FeatureLabel.Caption := '';
  StatesListBox.Items.Clear;
  StatesMemo.Lines.Clear;
  ItemListView.Columns[0].Caption :=
    Capitalize(strItems) + ' (' + IntToStr(Length(Dataset.ItemList)) + ')';
  CharacterListView.Columns[0].Caption :=
    Capitalize(strCharacters) + ' (' + IntToStr(Length(Dataset.CharacterList)) + ')';
  FileIsOpen := True;
  FileIsChanged := True;
  SaveBtn.Enabled := True;
  FileIsSaved := False;
  UpdateMenuItems(Self);
  UpdateStatusBar(Self);
  UpdateTitleBar(strUntitled);
end;

procedure TMainForm.FileCloseItemClick(Sender: TObject);
begin
  if FileIsChanged and (not FileIsSaved) then
    if (MessageDlg(strConfirmation, strSave, mtConfirmation, [mbYes, mbNo], 0) =
      mrYes) then
      FileSaveAsItemClick(Self);
  FileIsOpen := False;
  FileIsChanged := False;
  HasDistance := False;
  PageControl.Visible := False;
  UpdateMenuItems(Self);
  UpdateStatusBar(Self);
  MainForm.Caption := Application.Title;
  SaveDialog.FileName := '';
  OpenDialog.FileName := '';
end;

procedure TMainForm.EditTitleItemClick(Sender: TObject);
var
  title: string;
begin
  title := InputBox(strEditCaption, strEditPrompt, Dataset.Heading);
  if (title = '') then
    Dataset.Heading := strUntitled
  else if (title <> Dataset.Heading) then
  begin
    Dataset.Heading := title;
    FileIsChanged := True;
    SaveBtn.Enabled := True;
    UpdateTitleBar(OpenDialog.FileName);
  end;
end;

procedure TMainForm.CharacterListViewDblClick(Sender: TObject);
begin
  EditChangeCharacterItemClick(Self);
end;

procedure TMainForm.CharacterListViewKeyDown(Sender: TObject;
  var Key: word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    EditChangeCharacterItemClick(Self);
end;

procedure TMainForm.CharacterListViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: integer);
var
  Item: TListItem;
  I, J, K, L: integer;
  Attribute, States: string;
  Values: TStringList;
  CharSet: TSysCharSet;
begin
  CharSet := ['/', '&', '-'];

  if (ItemListView.Selected <> nil) then
    I := ItemListView.Selected.Index
  else
    I := 0;

  Item := CharacterListView.GetItemAt(X, Y);

  if (Item <> nil) and (Item <> FLastHintItem) then
  begin
    J := StrToIntDef(Copy(Item.Caption, 1, Pos('.', Item.Caption) - 1), 0) - 1;
    //CharacterListView.Hint := 'Details: ' + Item.Caption;
    Attribute := Delta.OmitTypesettingMarks(Dataset.ItemList[I].itemAttributes[J]);

    if (Dataset.CharacterList[J].charType = 'UM') or
      (Dataset.CharacterList[J].charType = 'OM') then
    begin
      if (not ContainsChars(Attribute, CharSet)) then
      begin
        try
          K := StrToInt(Attribute);
          CharacterListView.Hint :=
            Delta.OmitTypesettingMarks(Dataset.ItemList[I].itemAttributes[J]) +
            ' ' + Dataset.CharacterList[J].charStates[K - 1];
        except
          CharacterListView.Hint := Delta.RemoveComments(Attribute);
        end;
      end
      else
      begin
        Values := TStringList.Create;
        try
          Split(Values, Delta.RemoveComments(Attribute), ['/', '&', '-']);
        except
          on E: EStringListError do
            Values.Add('');
        end;
        States := '';
        for L := 0 to Values.Count - 1 do
        try
          begin
            K := StrToInt(Values[L]);
            States := States + ' ' + IntToStr(K) + ' ' + Delta.RemoveComments(
              Dataset.CharacterList[J].charStates[K - 1]);
          end;
        except
          ;
        end;
        Values.Free;
        CharacterListView.Hint := States;
      end;
    end

    else if (Dataset.CharacterList[J].charType = 'IN') or
      (Dataset.CharacterList[J].charType = 'RN') then
      CharacterListView.Hint :=
        Delta.OmitTypesettingMarks(Dataset.ItemList[I].itemAttributes[J]) +
        ' ' + Dataset.CharacterList[J].charUnit

    else if (Dataset.CharacterList[J].charType = 'TE') then
      CharacterListView.Hint :=
        Delta.OmitTypesettingMarks(Dataset.ItemList[I].itemAttributes[J]);

    Application.ActivateHint(Mouse.CursorPos);
    FLastHintItem := Item;
  end;
end;

procedure TMainForm.ExportDELTAItemClick(Sender: TObject);
var
  CurDir, Directory: string;
  Ok, Reply: boolean;
begin
  SelectDirectoryDialog.Title := strDataDirectory;
  SelectDirectoryDialog.Filename := '';
  Ok := True;
  if SelectDirectoryDialog.Execute then
  begin
    Directory := SelectDirectoryDialog.Filename;
    GetDir(0, CurDir);
    ChDir(Directory);
    if FileExists('chars') then
    begin
      Reply := MessageDlg(strConfirmation, Format(strExists, ['CHARS']),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
      if not Reply then
        Ok := False;
    end;
    if FileExists('items') then
    begin
      Reply := MessageDlg(strConfirmation, Format(strExists, ['ITEMS']),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
      if not Reply then
        Ok := False;
    end;
    if FileExists('specs') then
    begin
      Reply := MessageDlg(strConfirmation, Format(strExists, ['SPECS']),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
      if not Reply then
        Ok := False;
    end;
    if FileExists('cnotes') then
    begin
      Reply := MessageDlg(strConfirmation, Format(strExists, ['CNOTES']),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
      if not Reply then
        Ok := False;
    end;
    if Ok then
    begin
      Delta.WriteDelta(Dataset, 'chars', 'items', 'specs', 'cnotes');
      MessageDlg(strInformation, Format(strExport, [Directory]),
        mtInformation, [mbOK], 0);
    end;
    ChDir(CurDir);
  end;
end;

procedure TMainForm.ExportNexusItemClick(Sender: TObject);
var
  outfile: TextFile;
  tname, cname, sname, attribute: string;
  i, j, k, n, nchar, MaxLen: integer;
  Data: TStringList;
begin
  SaveDialog.FileName := ChangeFileExt(OpenDialog.FileName, '.nex');
  SaveDialog.Title := strSaveFile;
  SaveDialog.DefaultExt := '.nex';
  SaveDialog.Filter := strNEXUSFilter;
  if SaveDialog.Execute then
  begin
    AssignFile(outfile, SaveDialog.FileName);
    Rewrite(outfile);
    WriteLn(outfile, '#NEXUS');
    WriteLn(outfile);
    WriteLn(outfile, '[!', Dataset.Heading, ' ', DateTimeToStr(Now), ']');
    WriteLn(outfile);
    WriteLn(outfile, 'BEGIN TAXA;');
    WriteLn(outfile, StringOfChar(' ', 4), 'DIMENSIONS NTAX=',
      IntToStr(Length(Dataset.ItemList)), ';');
    WriteLn(outfile, StringOfChar(' ', 4), 'TAXLABELS');
    MaxLen := Length(Dataset.ItemList[0].itemName);
    for i := 0 to Length(Dataset.ItemList) - 1 do
    begin
      tname := Trim(OmitTypesettingMarks(RemoveComments(Dataset.ItemList[i].itemName)));
      tname := '''' + tname + '''';
      WriteLn(outfile, StringOfChar(' ', 8), tname);
      if Length(Dataset.ItemList[i].itemName) > MaxLen then
        MaxLen := Length(Dataset.ItemList[i].itemName);
    end;
    WriteLn(outfile, StringOfChar(' ', 8), ';');
    WriteLn(outfile, 'ENDBLOCK;');
    WriteLn(outfile);
    nchar := 0;
    for j := 0 to Length(Dataset.CharacterList) - 1 do
      if (Dataset.CharacterList[j].charType = 'UM') or
        (Dataset.CharacterList[j].charType = 'OM') then
        Inc(nchar);
    WriteLn(outfile, 'BEGIN CHARACTERS;');
    WriteLn(outfile, StringOfChar(' ', 4), 'DIMENSIONS NCHAR=', IntToStr(nchar), ';');
    WriteLn(outfile, StringOfChar(' ', 4),
      'FORMAT DATATYPE=STANDARD GAP=- MISSING=? SYMBOLS="0123456789";');
    WriteLn(outfile, StringOfChar(' ', 4), 'CHARLABELS');
    n := 1;
    for j := 0 to Length(Dataset.CharacterList) - 1 do
    begin
      if (Dataset.CharacterList[j].charType = 'UM') or
        (Dataset.CharacterList[j].charType = 'OM') then
      begin
        cname := Trim(OmitTypesettingMarks(Dataset.CharacterList[j].charName));
        if Pos(Chr(39), cname) > 0 then
          cname := StringReplace(cname, Chr(39), Chr(39) + Chr(39), [rfReplaceAll]);
        WriteLn(outfile, StringOfChar(' ', 8), '[', IntToStr(n),
          '] ', '''', cname, '''');
        Inc(n);
      end;
    end;
    WriteLn(outfile, StringOfChar(' ', 8), ';');
    WriteLn(outfile, StringOfChar(' ', 4), 'STATELABELS');
    n := 1;
    for j := 0 to Length(Dataset.CharacterList) - 1 do
    begin
      if (Dataset.CharacterList[j].charType = 'UM') or
        (Dataset.CharacterList[j].charType = 'OM') then
      begin
        Write(outfile, StringOfChar(' ', 8), IntToStr(n), ' ');
        for k := 0 to Dataset.CharacterList[j].charStates.Count - 1 do
        begin
          sname := Trim(OmitTypesettingMarks(Dataset.CharacterList[j].charStates[k]));
          if Pos(Chr(39), sname) > 0 then
            sname := StringReplace(sname, Chr(39), Chr(39) + Chr(39), [rfReplaceAll]);
          Write(outfile, '''', sname, '''', ', ');
        end;
        Inc(n);
        WriteLn(outfile);
      end;
    end;
    WriteLn(outfile, StringOfChar(' ', 4), ';');
    WriteLn(outfile, StringOfChar(' ', 4), 'MATRIX');
    for i := 0 to Length(Dataset.ItemList) - 1 do
    begin
      tname := Trim(OmitTypesettingMarks(RemoveComments(Dataset.ItemList[i].itemName)));
      tname := '''' + tname + '''';
      Write(outfile, StringOfChar(' ', 8), PadRight(tname, MaxLen + 4));
      for j := 0 to Dataset.ItemList[i].itemAttributes.Count - 1 do
      begin
        if (Dataset.CharacterList[j].charType = 'UM') or
          (Dataset.CharacterList[j].charType = 'OM') then
        begin
          attribute := Delta.RemoveComments(Dataset.ItemList[i].itemAttributes[j]);
          if attribute = 'U' then
            attribute := '?';
          if (Pos('-', attribute) > 0) or (Pos('&', attribute) > 0) or
            (Pos('/', attribute) > 0) then
          begin
            Data := TStringList.Create;
            Split(Data, attribute, ['-', '&', '/']);
            if Data.Count > 1 then
            begin
              Join(Data, attribute, '');
              attribute := '(' + attribute + ')';
            end;
            Data.Free;
          end;
          Write(outfile, attribute);
        end;
      end;
      WriteLn(outfile);
    end;
    WriteLn(outfile, StringOfChar(' ', 4), ';');
    WriteLn(outfile, 'ENDBLOCK;');
    WriteLn(outfile);
    WriteLn(outfile, 'BEGIN ASSUMPTIONS;');
    WriteLn(outfile, StringOfChar(' ', 4), 'OPTIONS DEFTYPE=UNORD POLYTCOUNT=MINSTEPS;');
    WriteLn(outfile, StringOfChar(' ', 4), 'TYPESET * default = UNORD: 1-',
      IntToStr(nchar), ';');
    WriteLn(outfile, StringOfChar(' ', 4), 'WTSET * default = 1: 1-',
      IntToStr(nchar), ';');
    WriteLn(outfile, 'ENDBLOCK;');
    CloseFile(outfile);
    MessageDlg(strInformation, Format(strExport, [SaveDialog.FileName]),
      mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.ExportSLIKSItemClick(Sender: TObject);
var
  NewDataset: TDelta;
  i, j: integer;
  ret_val: integer;
  excluded, attrib: string;
  outfile: TextFile;
  sPath, ConforPath: string;
  S: ansistring;
  Ok: boolean;
begin
  { Exclude numeric and text characters from character list }
  excluded := '';
  for i := 0 to Length(Dataset.CharacterList) - 1 do
  begin
    if (Dataset.CharacterList[i].charType = 'IN') or
      (Dataset.CharacterList[i].charType = 'RN') or
      (Dataset.CharacterList[i].charType = 'TE') then
      excluded += IntToStr(i + 1) + ' ';
  end;

  Ok := False;
  sPath := ExtractFilePath(Application.ExeName);
  {$IFDEF WINDOWS}
  ConforPath := sPath + 'confor.exe';
  {$ELSE}
  ConforPath := sPath + 'confor';
  {$ENDIF}
  if FileExists('specs') then
    Ok := True
  else
    MessageDlg(strInformation, Format(strNotFound, ['SPECS']),
      mtInformation, [mbOK], 0);
  if FileExists('chars') then
    Ok := True
  else
    MessageDlg(strInformation, Format(strNotFound, ['CHARS']),
      mtInformation, [mbOK], 0);
  if FileExists('items') then
    Ok := True
  else
    MessageDlg(strInformation, Format(strNotFound, ['ITEMS']),
      mtInformation, [mbOK], 0);
  if Ok then
  begin
    CreateTODEL('todel', Dataset.Heading, '', excluded);
    if not RunCommand(ConforPath, ['todel'], S, [poNoConsole]) then
    begin
      MessageDlg(strError, Format(strNotExecute, ['CONFOR']), mtError, [mbOK], 0);
      ShowErrorLog(S);
      Ok := False;
      Exit;
    end;
  end;

  { Open the new trimmed DELTA dataset }
  NewDataset := TDelta.Create;

  ret_val := NewDataset.ReadChars('chars.new');
  if (ret_val < 0) then
  begin
    MessageDlg(strError, Format(strReadError, ['CHARS']), mtError, [mbOK], 0);
    exit;
  end {else ShowMessage('Characters read')};

  ret_val := NewDataset.ReadItems('items.new');
  if (ret_val < 0) then
  begin
    MessageDlg(strError, Format(strReadError, ['ITEMS']), mtError, [mbOK], 0);
    exit;
  end {else ShowMessage('Items read')};

  ret_val := NewDataset.WriteSpecs('specs.new');
  if (ret_val < 0) then
  begin
    MessageDlg(strError, Format(strWriteError, ['SPECS']), mtError, [mbOK], 0);
    exit;
  end {else ShowMessage('Specifications written')};

  ret_val := NewDataset.ReadSpecs('specs.new', typeDirective);
  if (ret_val < 0) then
  begin
    MessageDlg(strError, Format(strReadError, ['SPECS']), mtError, [mbOK], 0);
    exit;
  end {else ShowMessage('Types read')};

  //NewDataset := Delta.ReadDelta('chars.new', 'items.new', 'specs.new');
  //NewDataset := Delta.ReadDelta('chars', 'items', 'specs');

  { Translate into SLIKS format }
  AssignFile(outfile, 'data.js');
  Rewrite(outfile);
  WriteLn(outfile);
  WriteLn(outfile, 'var dataset = "<h2>', Dataset.Heading, '</h2>"');

  { Output characters list }
  WriteLn(outfile);
  WriteLn(outfile, 'var chars = [ [ "Latin Name"],');
  for i := 0 to Length(NewDataset.CharacterList) - 1 do
  begin
    Write(outfile, #9, '[ "', NewDataset.CharacterList[i].charName, '", ');
    for j := 0 to NewDataset.CharacterList[i].charStates.Count - 1 do
    begin
      try
        if (j < NewDataset.CharacterList[i].charStates.Count - 1) then
          Write(outfile, '"', NewDataset.CharacterList[i].charStates[j], '", ')
        else
          Write(outfile, '"', Dataset.CharacterList[i].charStates[j], '"');
      except
        continue;
      end;
    end;
    if (i < Length(NewDataset.CharacterList) - 1) then
      Write(outfile, '],')
    else
      Write(outfile, '] ]');
    WriteLn(outfile);
  end;

  { Output data matrix }
  WriteLn(outfile);
  WriteLn(outfile, 'var items = [ [""],');
  for i := 0 to Length(NewDataset.ItemList) - 1 do
  begin
    Write(outfile, #9, '["', NewDataset.ItemList[i].itemName, '", ');
    for j := 0 to NewDataset.ItemList[i].itemAttributes.Count - 1 do
    begin
      attrib := Delta.RemoveComments(NewDataset.ItemList[i].itemAttributes[j]);
      if (Pos('/', attrib) > 0) or (attrib = 'U') then
        attrib := '?';
      if (j < NewDataset.ItemList[i].itemAttributes.Count - 1) then
        //Write(outfile, '"', NewDataset.ItemList[i].itemAttributes[j], '",')
        Write(outfile, '"', attrib, '",')
      else
        //Write(outfile, '"', NewDataset.ItemList[i].itemAttributes[j], '"');
        Write(outfile, '"', attrib, '"');
    end;
    if (i < Length(NewDataset.ItemList) - 1) then
      Write(outfile, '],')
    else
      Write(outfile, '] ]');
    WriteLn(outfile);
  end;

  CloseFile(outfile);
  NewDataset.Free;
  MessageDlg(strInformation, Format(strExportFile, ['data.js']),
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.ExportSpreadsheetItemClick(Sender: TObject);
begin
  SaveDialog.FileName := ChangeFileExt(ExtractFileName(OpenDialog.FileName), '.xls');
  SaveDialog.Title := strSaveFile;
  SaveDialog.DefaultExt := '.xls';
  SaveDialog.Filter := strXLSFilter;
  if SaveDialog.Execute then
  begin
    if SaveAsExcelFile(DataMatrix, SaveDialog.FileName) then
      MessageDlg(strInformation, Format(strExportFile, [SaveDialog.FileName]),
        mtInformation, [mbOK], 0)
    else
      MessageDlg(strSaveError, Format(strExportFile, [SaveDialog.FileName]),
        mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.ExportTextItemClick(Sender: TObject);
begin
  SaveDialog.FileName := ChangeFileExt(ExtractFileName(OpenDialog.FileName), '.txt');
  SaveDialog.Title := strSaveFile;
  SaveDialog.DefaultExt := '.txt';
  SaveDialog.Filter := strTxtFilter;
  if SaveDialog.Execute then
  begin
    DataMatrix.SaveToCSVFile(SaveDialog.FileName, #9);
    MessageDlg(strInformation, Format(strExportFile, [SaveDialog.FileName]),
      mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.ExportTNTItemClick(Sender: TObject);
var
  outfile: TextFile;
  tname, attribute, states: string;
  i, j, k, n, nchar, maxlen: integer;
  Data: TStringList;
begin
  SaveDialog.FileName := ChangeFileExt(OpenDialog.FileName, '.tnt');
  SaveDialog.Title := strSaveFile;
  SaveDialog.DefaultExt := '.tnt';
  SaveDialog.Filter := strTNTFilter;
  if SaveDialog.Execute then
  begin
    AssignFile(outfile, SaveDialog.FileName);
    Rewrite(outfile);
    WriteLn(outfile, 'xread');
    WriteLn(outfile, '''', Dataset.Heading, '''');
    nchar := 0;
    for j := 0 to Length(Dataset.CharacterList) - 1 do
      if (Dataset.CharacterList[j].charType = 'UM') or
        (Dataset.CharacterList[j].charType = 'OM') then
        Inc(nchar);
    WriteLn(outfile, IntToStr(nchar), ' ', IntToStr(Length(Dataset.ItemList)));
    //maxlen := Length(RemoveComments(Dataset.ItemList[0].itemName));
    //for i := 0 to Length(Dataset.ItemList) - 1 do
    //begin
    //tname := OmitTypesettingMarks(RemoveComments(Dataset.ItemList[i].itemName));
    //if Length(tname) > maxlen then
    //  maxlen := Length(tname);
    //end;
    for i := 0 to Length(Dataset.ItemList) - 1 do
    begin
      //Write(outfile, PadRight(Dataset.ItemList[i].itemName, maxlen + 1));
      tname := OmitTypesettingMarks(RemoveComments(Dataset.ItemList[i].itemName));
      WriteLn(outfile, StringReplace(tname, ' ', '_', [rfReplaceAll]));
      for j := 0 to Dataset.ItemList[i].itemAttributes.Count - 1 do
      begin
        if (Dataset.CharacterList[j].charType = 'UM') or
          (Dataset.CharacterList[j].charType = 'OM') then
        begin
          attribute := RemoveComments(Dataset.ItemList[i].itemAttributes[j]);
          if attribute = 'U' then
            attribute := '?';
          if (Pos('-', attribute) > 0) or (Pos('&', attribute) > 0) or
            (Pos('/', attribute) > 0) then
          begin
            Data := TStringList.Create;
            Split(Data, attribute, ['-', '&', '/']);
            if Data.Count > 1 then
            begin
              Join(Data, attribute, '');
              attribute := '[' + attribute + ']';
            end;
            Data.Free;
          end;
          Write(outfile, attribute);
        end;
      end;
      WriteLn(outfile);
    end;
    WriteLn(outfile, ';');
    WriteLn(outfile);
    WriteLn(outfile, 'hold 100;');
    WriteLn(outfile);
    WriteLn(outfile, 'cnames');
    n := 0;
    for j := 0 to Length(Dataset.CharacterList) - 1 do
    begin
      if (Dataset.CharacterList[j].charType = 'UM') or
        (Dataset.CharacterList[j].charType = 'OM') then
      begin
        Write(outfile, '{ ', IntToStr(n), ' ',
          StringReplace(Trim(Dataset.CharacterList[j].charName), ' ',
          '_', [rfReplaceAll]), ' ');
        states := '';
        for k := 0 to Dataset.CharacterList[j].charStates.Count - 1 do
          states := states + StringReplace(
            Trim(Dataset.CharacterList[j].charStates[k]), ' ', '_',
            [rfReplaceAll]) + ' ';
        WriteLn(outfile, Trim(states), ';');
        Inc(n);
      end;
    end;
    WriteLn(outfile, ';');
    WriteLn(outfile);
    WriteLn(outfile, 'proc/;');
    CloseFile(outfile);
    MessageDlg(strInformation, Format(strExport, [SaveDialog.FileName]),
      mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.ExportXDELTAItemClick(Sender: TObject);
var
  outfile: TextFile;
  i, j, k, n, p, q: integer;
  values: TStringList;
  startval, endval, lowerval, upperval, range, attribute, comment: string;
begin
  SaveDialog.FileName := ChangeFileExt(ExtractFileName(OpenDialog.FileName), '.xml');
  SaveDialog.Title := strSaveFile;
  SaveDialog.DefaultExt := '.xml';
  SaveDialog.Filter := strXMLFilter;
  if SaveDialog.Execute then
  begin
    AssignFile(outfile, SaveDialog.FileName);
    Rewrite(outfile);
    WriteLn(outfile, '<?xml version="1.0"?>');
    WriteLn(outfile, '<!DOCTYPE xdelta SYSTEM "xdelta.dtd">');
    WriteLn(outfile);
    WriteLn(outfile, '<xdelta revised="', DateTimeToStr(Now), '">');
    WriteLn(outfile, '   <description>', Dataset.Heading, '.</description>');
    WriteLn(outfile);
    WriteLn(outfile, '   <character-list>');
    for i := 0 to Length(Dataset.CharacterList) - 1 do
    begin
      WriteLn(outfile, '   <character number="', i + 1, '>"');
      WriteLn(outfile, '      <description>',
        RemoveComments(Dataset.CharacterList[i].charName), '</description>');
      case Dataset.CharacterList[i].charType of
        'UM':
        begin
          WriteLn(outfile, '      <multi type="unordered">');
          for j := 0 to Dataset.CharacterList[i].charStates.Count - 1 do
            WriteLn(outfile, '         <state number="', j + 1, '">',
              RemoveComments(Dataset.CharacterList[i].charStates[j]), '</state>');
          WriteLn(outfile, '      </multi>');
        end;
        'OM':
        begin
          WriteLn(outfile, '      <multi type="ordered">');
          for j := 0 to Dataset.CharacterList[i].charStates.Count - 1 do
            WriteLn(outfile, '         <state number="', j + 1, '">',
              RemoveComments(Dataset.CharacterList[i].charStates[j]), '</state>');
          WriteLn(outfile, '      </multi>');
        end;
        'IN': WriteLn(outfile, '      <num type="integer">');
        'RN': WriteLn(outfile, '      <num type="real" units="',
            RemoveComments(Dataset.CharacterList[i].charUnit), '">');
        'TE': WriteLn(outfile, '      <txt>');
      end;
      WriteLn(outfile, '   </character>');
      WriteLn(outfile);
    end;
    WriteLn(outfile, '   </character-list>');
    WriteLn(outfile);
    WriteLn(outfile, '   <item-list>');
    for i := 0 to Length(Dataset.ItemList) - 1 do
    begin
      WriteLn(outfile, '   <item itemid="', i + 1, '">');
      WriteLn(outfile, '      <item-name>', Dataset.ItemList[i].itemName,
        '</item-name>');
      WriteLn(outfile, '      <attribute-list>');
      for k := 0 to Dataset.ItemList[i].itemAttributes.Count - 1 do
      begin
        attribute := Dataset.ItemList[i].itemAttributes[k];
        if Pos('-', attribute) > 0 then
        begin
          if Pos(',', attribute) > 0 then
          begin
            comment := ExtractDelimited(1, attribute, [',']);
            comment := StringReplace(comment, '<', '(', [rfReplaceAll]);
            comment := StringReplace(comment, '>', ')', [rfReplaceAll]);
            attribute := ExtractDelimited(2, attribute, [',']);
          end;
          if Pos('(', attribute) = 1 then
          begin
            { Get lower value }
            p := Pos('(', attribute);
            q := Pos(')', attribute);
            lowerval := Copy(attribute, p, q - p + 1);
            range := Copy(attribute, Length(lowerval) + 1, Length(attribute));
            lowerval := StripChars(lowerval, ['(', '-', ')']);
            startval := ExtractDelimited(1, range, ['-']);
            endval := ExtractDelimited(2, range, ['-']);
            if Length(comment) > 0 then
              lowerval := comment + ',' + lowerval;
            WriteLn(outfile, '         <attribute character="', k + 1,
              '"><value lower="', lowerval, '" start="', startval, '" end="',
              endval, '">', '</value></attribute>');
          end
          else if Pos('(', attribute) > 1 then
          begin
            { Get upper value }
            p := LastPos('(', attribute);
            q := LastPos(')', attribute);
            upperval := Copy(attribute, p, q - p + 1);
            range := Copy(attribute, 1, Pos('(', attribute) - 1);
            upperval := StripChars(upperval, ['(', '-', ')']);
            startval := ExtractDelimited(1, range, ['-']);
            endval := ExtractDelimited(2, range, ['-']);
            WriteLn(outfile, '         <attribute character="', k + 1,
              '"><value start="', startval, '" end="', endval, '" upper="', upperval,
              '">', '</value></attribute>');
          end
          else
          begin
            attribute := StringReplace(attribute, '<', '(', [rfReplaceAll]);
            attribute := StringReplace(attribute, '>', ')', [rfReplaceAll]);
            startval := ExtractDelimited(1, attribute, ['-']);
            endval := ExtractDelimited(2, attribute, ['-']);
            if Length(endval) > 0 then
              WriteLn(outfile, '         <attribute character="', k + 1,
                '"><value start="', startval, '" end="', endval, '">',
                '</value></attribute>');
          end;
        end
        else if Pos('/', attribute) > 0 then
        begin
          values := TStringList.Create;
          try
            attribute := StringReplace(attribute, '<', '(', [rfReplaceAll]);
            attribute := StringReplace(attribute, '>', ')', [rfReplaceAll]);
            SplitString('/', attribute, values);
            Write(outfile, '         <attribute character="', k + 1, '">');
            for n := 0 to values.Count - 1 do
              Write(outfile, '<value>', values[n], '</value>');
            WriteLn(outfile, '</attribute>');
          finally
            values.Free;
          end;
        end
        else if Pos('&', attribute) > 0 then
        begin
          values := TStringList.Create;
          try
            attribute := StringReplace(attribute, '<', '(', [rfReplaceAll]);
            attribute := StringReplace(attribute, '>', ')', [rfReplaceAll]);
            SplitString('/', attribute, values);
            Write(outfile, '         <attribute character="', k + 1, '">');
            for n := 0 to values.Count - 1 do
              Write(outfile, '<value>', values[n], '</value>');
            WriteLn(outfile, '</attribute>');
          finally
            values.Free;
          end;
        end
        else
        begin
          attribute := StringReplace(attribute, '<', '(', [rfReplaceAll]);
          attribute := StringReplace(attribute, '>', ')', [rfReplaceAll]);
          WriteLn(outfile, '         <attribute character="', k + 1, '"><value>',
            attribute, '</value></attribute>');
        end;
      end;
      WriteLn(outfile, '      </attribute-list>');
      WriteLn(outfile, '   </item>');
      WriteLn(outfile);
    end;
    WriteLn(outfile, '   </item-list>');
    WriteLn(outfile, '</xdelta>');
    CloseFile(outfile);
    MessageDlg(strInformation, Format(strExportFile, [SaveDialog.FileName]),
      mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.FileClearMRUItemClick(Sender: TObject);
var
  I: integer;
begin
  for I := 0 to HistoryFiles.Count - 1 do
  begin
    HistoryFiles.DeleteItem(I);
    HistoryFiles.UpdateParentMenu;
  end;
  UpdateMenuItems(Self);
end;

procedure TMainForm.DataMatrixDrawCell(Sender: TObject; aCol, aRow: integer;
  aRect: TRect; aState: TGridDrawState);
var
  grid: TStringGrid;
  S: string;
  drawrect: TRect;
  bgFill: TColor;
begin
  if (ARow > 0) then
    Exit;
  grid := Sender as TStringGrid;
  if gdFixed in aState then
    bgFill := $FFF8F8
  else
  if gdSelected in aState then
    bgFill := $FFF0D0
  else
    bgFill := clWhite;
  grid.Canvas.Brush.Color := bgFill;
  grid.Canvas.Brush.Style := bsSolid;
  grid.Canvas.FillRect(aRect);
  S := grid.Cells[ACol, ARow];
  if Length(S) > 0 then
  begin
    drawrect := aRect;
    drawrect.Inflate(-4, 0);
    DrawText(grid.Canvas.Handle, PChar(S), Length(S), drawrect,
      dt_calcrect or dt_wordbreak or dt_left);
    if (drawrect.Bottom - drawrect.Top) > grid.RowHeights[ARow] then
      grid.RowHeights[ARow] := (drawrect.Bottom - drawrect.Top + 2)
    else
    begin
      drawrect.Right := aRect.Right;
      DrawText(grid.Canvas.Handle, PChar(S), Length(S), drawrect,
        dt_wordbreak or dt_left);
    end;
  end;
  if gdFocused in aState then
    grid.Canvas.DrawFocusRect(aRect);
end;

procedure TMainForm.DataMatrixPrepareCanvas(Sender: TObject;
  aCol, aRow: integer; aState: TGridDrawState);
var
  ts: TTextStyle;
begin
  if (Dataset <> nil) and (Length(Dataset.CharacterList) <> 0) then
  begin
    //if ARow = 0 then
    //  DataMatrix.Canvas.Font.Style := [fsBold];        // bold for header row
    if (ACol > 0) then
    begin
      ts := DataMatrix.Canvas.TextStyle;
      if (Dataset.CharacterList[ACol - 1].charType = 'TE') then
        ts.Alignment := taLeftJustify
      else
        ts.Alignment := taCenter;
      DataMatrix.Canvas.TextStyle := ts;
      if (ARow > 0) then
      begin
        if (Dataset.CharacterList[ACol - 1].charImplicit = 1) then
        begin
          if (DataMatrix.Cells[ACol, ARow] <> '') then
            DataMatrix.Canvas.Font.Color := clSilver;        // implicit values in gray
        end;
        if (DataMatrix.Cells[ACol, ARow] = '-') then
          //DataMatrix.Canvas.Font.Color := clRed;         // inapplicable values in red
          DataMatrix.Canvas.Brush.Color := clSilver;
      end;
    end;
  end;
end;

procedure TMainForm.DataMatrixSelectCell(Sender: TObject; aCol, aRow: integer;
  var CanSelect: boolean);
var
  J, K: integer;
  Attribute: string;
  Values: TStringList;
begin
  if (Dataset <> nil) and (Length(Dataset.CharacterList) <> 0) then
  begin
    FeatureLabel.Caption := DataMatrix.Cells[aCol, 0];
    case Dataset.CharacterList[aCol - 1].charType of
      'UM', 'OM':
      begin
        StatesListBox.Visible := True;
        StatesMemo.Visible := False;
        StatesListBox.Items.Clear;
        for J := 0 to Dataset.CharacterList[aCol - 1].charStates.Count - 1 do
          StatesListBox.items.Add(Concat(IntToStr(J + 1), '. ',
            Dataset.CharacterList[aCol - 1].charStates[J]));
        Attribute := Dataset.ItemList[aRow - 1].itemAttributes[aCol - 1];
        Values := TStringList.Create;
        Split(Values, Delta.RemoveComments(Attribute), ['/', '&', '-']);
        for K := 0 to StatesListbox.Count - 1 do
          StatesListBox.Checked[K] := Values.IndexOf(IntToStr(K + 1)) > -1;
        Values.Free;
        if Dataset.CharacterList[aCol - 1].charImplicit > 0 then
          StatesListBox.Font.Color := clSilver;
      end;
      'IN', 'RN':
      begin
        StatesListBox.Visible := False;
        StatesMemo.Visible := True;
        StatesMemo.Lines.Clear;
        StatesMemo.Lines.Add(Dataset.CharacterList[aCol - 1].charUnit);
      end;
      'TE':
      begin
        StatesListBox.Visible := False;
        StatesMemo.Visible := True;
        StatesMemo.Lines.Clear;
        if Dataset.ItemList <> nil then
          StatesMemo.Lines.Add(
            Dataset.ItemList[aRow - 1].itemAttributes[aCol - 1]);
        StatesMemo.SelStart := 0;
      end;
    end;
  end;
end;

procedure TMainForm.EditAddCharacterItemClick(Sender: TObject);
var
  CharName, CharType, CharUnit, CharNote, Rule: string;
  CharCount, CharImplicit, I, N, J, K, M: integer;
  StatesList: TStringList;
  CharNode: TListItem;
  Character: Delta.TCharacter;
begin
  with CharacterForm do
  begin
    CharNumber := Length(Dataset.CharacterList) + 1;
    Caption := strAddCharacter;
    EditChar.Text := '';
    EditNote.Lines.Clear;
    rbUM.Checked := True;
    rbOM.Checked := False;
    rbIN.Checked := False;
    rbRN.Checked := False;
    rbTE.Checked := False;
    ListStates.Clear;
    CheckImplicit.Checked := False;
    EditUnit.Text := '';
    StateImplicit := 0;
  end;
  if CharacterForm.ShowModal = mrOk then
  begin
    with CharacterForm do
    begin
      CharName := EditChar.Text;
      CharNote := EditNote.Lines.Text;
      if not IsEmptyStr(CharName, [' ']) then
      begin
        if rbUM.Checked then
          CharType := 'UM'
        else if rbOM.Checked then
          CharType := 'OM'
        else if rbIN.Checked then
          CharType := 'IN'
        else if rbRN.Checked then
          CharType := 'RN'
        else if rbTE.Checked then
          CharType := 'TE';
        if (CharType = 'UM') or (CharType = 'OM') then
        begin
          if ListStates.Items.Count > 0 then
          begin
            StatesList := TStringList.Create;
            StatesList.Assign(ListStates.Items);
          end;
        end;
        if (CharType = 'IN') or (CharType = 'RN') then
          CharUnit := EditUnit.Text;
        if EditNote.Lines.Count > 0 then
          CharNote := EditNote.Text;
        if StateImplicit > 0 then
          CharImplicit := StateImplicit;
        CharCount := Length(Dataset.CharacterList);
        SetLength(Dataset.CharacterList, CharCount + 1);
        Dataset.CharacterList[charCount].charName := CharName;
        Dataset.CharacterList[charCount].charType := CharType;
        Dataset.CharacterList[charCount].charUnit := CharUnit;
        Dataset.CharacterList[charCount].charImplicit := CharImplicit;
        Dataset.CharacterList[charCount].charNote := CharNote;
        Dataset.CharacterList[charCount].charStates := StatesList;
        Dataset.CharacterList[CharCount].charDependent := DependentChar;
        for J := 0 to Length(Dataset.ItemList) - 1 do
          Dataset.ItemList[J].itemAttributes.Add('U');
        CharacterListView.Columns[0].Caption :=
          Capitalize(strCharacters) + ' (' +
          IntToStr(Length(Dataset.CharacterList)) + ')';
        CharNode := CharacterListView.Items.Add;
        CharNode.Caption := IntToStr(charCount + 1) + '. ' +
          Dataset.CharacterList[charCount].charName;
        case Dataset.CharacterList[charCount].charType of
          'UM', 'OM':
          begin
            if (Dataset.CharacterList[charCount].charType = 'UM') then
              CharNode.ImageIndex := 18
            else if (Dataset.CharacterList[charCount].charType = 'OM') then
              CharNode.ImageIndex := 28;
          end;
          'IN', 'RN':
          begin
            if (Dataset.CharacterList[charCount].charType = 'IN') then
              CharNode.ImageIndex := 17
            else if (Dataset.CharacterList[charCount].charType = 'RN') then
              CharNode.ImageIndex := 27;
          end;
          'TE':
            CharNode.ImageIndex := 19;
        end;
        DataMatrix.ColCount := DataMatrix.ColCount + 1;
        DataMatrix.Cells[charCount + 1, 0] := CharName;
        for J := 1 to DataMatrix.RowCount - 1 do
          DataMatrix.Cells[charCount + 1, J] := 'U';
        DataMatrix.Refresh;
        FileIsChanged := True;
        SaveBtn.Enabled := True;
        UpdateMenuItems(Self);
        UpdateStatusBar(Self);
        UpdateTitleBar(OpenDialog.FileName);
        CharacterListView.Selected := CharacterListView.Items[charCount];
      end;
    end;
  end;
end;

procedure TMainForm.EditAddItemClick(Sender: TObject);
var
  ItemStr, ItemName, ItemComment, TempStr: string;
  ItemCount, J: integer;
  Item: TListItem;
begin
  TempStr := StatusLine.SimpleText;
  StatusLine.SimpleText := strItemStatus;
  ItemStr := InputBox(strAddItemCaption, strAddItemPrompt, '');
  if not IsEmptyStr(ItemStr, [' ']) then
  begin
    if Pos('<', ItemStr) > 0 then
    begin
      ItemName := Trim(Copy(ItemStr, 1, Pos('<', ItemStr) - 1));
      ItemComment := Copy(ItemStr, Pos('<', ItemStr), Pos('>', ItemStr));
    end
    else
    begin
      ItemName := ItemStr;
      ItemComment := '';
    end;
    ItemCount := Length(Dataset.ItemList);
    SetLength(Dataset.ItemList, ItemCount + 1);
    Dataset.ItemList[ItemCount].itemName := ItemName;
    Dataset.ItemList[ItemCount].itemComment := ItemComment;
    Dataset.ItemList[ItemCount].itemAttributes := TStringList.Create;
    for J := 0 to Length(Dataset.CharacterList) - 1 do
      Dataset.ItemList[itemCount].itemAttributes.Add('U');
    ItemListView.Columns[0].Caption :=
      Capitalize(strItems) + ' (' + IntToStr(Length(Dataset.ItemList)) + ')';
    Item := ItemListView.Items.Add;
    Item.Caption := IntToStr(itemCount + 1) + '. ' +
      Dataset.ItemList[itemCount].itemName + ' ' +
      Dataset.ItemList[itemCount].itemComment;
    ItemListView.Refresh;
    DataMatrix.InsertColRow(False, ItemCount + 1);
    DataMatrix.Cells[0, ItemCount + 1] := ItemName + ' ' + ItemComment;
    for J := 1 to DataMatrix.ColCount - 1 do
      DataMatrix.Cells[J, ItemCount + 1] := 'U';
    DataMatrix.Refresh;
    LoadCharacterList;
    FileIsChanged := True;
    SaveBtn.Enabled := True;
    ItemListView.Selected := ItemListView.Items[ItemCount];
    if PageControl.TabIndex = 0 then
      ItemListView.SetFocus;
    UpdateMenuItems(Self);
    UpdateStatusBar(Self);
    UpdateTitleBar(OpenDialog.FileName);
  end;
  StatusLine.SimpleText := TempStr;
end;

procedure TMainForm.EditChangeCharacterItemClick(Sender: TObject);
var
  CharName, CharType, CharUnit, CharNote, Rule: string;
  CharIndex, CharImplicit, I, N: integer;
  StatesList: TStringList;
  Character: TCharacter;
begin
  CharIndex := CharacterListView.ItemIndex;
  if CharIndex >= 0 then
  begin
    with CharacterForm do
    begin
      CharNumber := CharIndex;
      Caption := strEditCharacter;
      EditChar.Text := Dataset.CharacterList[CharIndex].charName;
      EditNote.Lines.AddText(Dataset.CharacterList[CharIndex].charNote);
      if (Dataset.CharacterList[CharIndex].charType = 'UM') then
        rbUM.Checked := True
      else
        rbUM.Checked := False;
      if (Dataset.CharacterList[CharIndex].charType = 'OM') then
        rbOM.Checked := True
      else
        rbOM.Checked := False;
      if (Dataset.CharacterList[CharIndex].charType = 'IN') then
        rbIN.Checked := True
      else
        rbIN.Checked := False;
      if (Dataset.CharacterList[CharIndex].charType = 'RN') then
        rbRN.Checked := True
      else
        rbRN.Checked := False;
      if (Dataset.CharacterList[CharIndex].charType = 'TE') then
        rbTE.Checked := True
      else
        rbTE.Checked := False;
      ListStates.Items.Clear;
      if (Dataset.CharacterList[CharIndex].charType = 'UM') or
        (Dataset.CharacterList[CharIndex].charType = 'OM') then
        ListStates.Items.Assign(Dataset.CharacterList[CharIndex].charStates);
      EditUnit.Text := Dataset.CharacterList[CharIndex].charUnit;
      if Dataset.CharacterList[CharIndex].charImplicit > 0 then
      begin
        CheckImplicit.Checked := True;
        StateImplicit := Dataset.CharacterList[CharIndex].charImplicit;
      end;
    end;
    if CharacterForm.ShowModal = mrOk then
    begin
      with CharacterForm do
      begin
        CharName := EditChar.Text;
        CharNote := EditNote.Lines.Text;
        if not IsEmptyStr(CharName, [' ']) then
        begin
          if rbUM.Checked then
            CharType := 'UM'
          else if rbOM.Checked then
            CharType := 'OM'
          else if rbIN.Checked then
            CharType := 'IN'
          else if rbRN.Checked then
            CharType := 'RN'
          else if rbTE.Checked then
            CharType := 'TE';
          if (CharType = 'IN') or (CharType = 'RN') then
            CharUnit := EditUnit.Text;
          if (CharType = 'UM') or (CharType = 'OM') then
          begin
            if ListStates.Items.Count > 0 then
            begin
              StatesList := TStringList.Create;
              StatesList.Assign(ListStates.Items);
            end;
          end;
          if StateImplicit > 0 then
            CharImplicit := StateImplicit;
          if EditNote.Lines.Count > 0 then
            CharNote := EditNote.Text;
          Dataset.CharacterList[CharIndex].charName := CharName;
          Dataset.CharacterList[CharIndex].charType := CharType;
          Dataset.CharacterList[CharIndex].charUnit := CharUnit;
          Dataset.CharacterList[CharIndex].charImplicit := CharImplicit;
          Dataset.CharacterList[CharIndex].charNote := CharNote;
          Dataset.CharacterList[CharIndex].charDependent := DependentChar;
          if ListStates.Items.Count > 0 then
            Dataset.CharacterList[CharIndex].charStates := StatesList;
          LoadCharacterList(CharIndex);
          DataMatrix.Cells[CharIndex, 0] := CharName;
          DataMatrix.Refresh;
          FileIsChanged := True;
          SaveBtn.Enabled := True;
          UpdateMenuItems(Self);
          UpdateTitleBar(OpenDialog.FileName);
        end;
        CharacterListView.ItemIndex := CharIndex;
        CharacterListView.Selected;
      end;
    end;
  end;
end;

procedure TMainForm.EditChangeItemClick(Sender: TObject);
var
  ItemCaption, ItemStr, ItemName, ItemComment, TempStr: string;
  ItemIndex: integer;
  Ok: boolean;
begin
  ItemIndex := ItemListView.ItemIndex;
  if ItemIndex >= 0 then
  begin
    TempStr := StatusLine.SimpleText;
    StatusLine.SimpleText := strItemStatus;
    ItemCaption := ItemListView.Selected.Caption;
    ItemStr := Trim(Copy(ItemCaption, Pos('.', ItemCaption) + 1));
    Ok := InputQuery(strEditItemCaption, strEditItemPrompt, ItemStr);
    if Ok and not IsEmptyStr(ItemStr, [' ']) then
    begin
      if Pos('<', ItemStr) > 0 then
      begin
        ItemName := Trim(Copy(ItemStr, 1, Pos('<', ItemStr) - 1));
        ItemComment := Copy(ItemStr, Pos('<', ItemStr), Pos('>', ItemStr));
      end
      else
      begin
        ItemName := ItemStr;
        ItemComment := '';
      end;
      Dataset.ItemList[ItemIndex].itemName := ItemName;
      Dataset.ItemList[ItemIndex].itemComment := ItemComment;
      LoadItemList;
      DataMatrix.Cells[0, ItemIndex] := ItemName + ' ' + ItemComment;
      DataMatrix.Refresh;
      FileIsChanged := True;
      SaveBtn.Enabled := True;
      UpdateTitleBar(OpenDialog.FileName);
      ItemListView.ItemIndex := ItemIndex;
      ItemListView.Selected;
      if PageControl.TabIndex = 0 then
        ItemListView.SetFocus;
    end;
    StatusLine.SimpleText := TempStr;
  end;
end;

procedure TMainForm.EditCloneItemClick(Sender: TObject);
var
  ItemCaption, ItemStr, ItemName, ItemComment: string;
  ItemIndex, ItemCount, I, J: integer;
  Item: Delta.TItem;
  Sel: TListItem;
  Ok: boolean;
begin
  ItemIndex := ItemListView.ItemIndex;
  if ItemIndex >= 0 then
  begin
    ItemCaption := ItemListView.Selected.Caption;
    ItemStr := strCloneItem + ' ' + Trim(Copy(ItemCaption, Pos('.', ItemCaption) + 1));
    Ok := InputQuery(strEditItemCaption, strEditItemPrompt, ItemStr);
    if Ok and not IsEmptyStr(ItemStr, [' ']) then
    begin
      if Pos('<', ItemStr) > 0 then
      begin
        ItemName := Trim(Copy(ItemStr, 1, Pos('<', ItemStr) - 1));
        ItemComment := Copy(ItemStr, Pos('<', ItemStr), Pos('>', ItemStr));
      end
      else
      begin
        ItemName := ItemStr;
        ItemComment := '';
      end;
      ItemCount := Length(Dataset.ItemList);
      Item.itemName := ItemName;
      Item.itemComment := ItemComment;
      Item.itemAttributes := TStringList.Create;
      Item.itemAttributes.Assign(Dataset.ItemList[ItemIndex].itemAttributes);
      InsertOneItem(Dataset.ItemList, ItemIndex, Item);
      Sel := ItemListView.Items.Insert(ItemIndex);
      Sel.Caption := IntToStr(itemCount + 1) + '. ' + Item.itemName +
        ' ' + Item.itemComment;
      ItemListView.Columns[0].Caption :=
        Capitalize(strItems) + ' (' + IntToStr(ItemListView.Items.Count) + ')';
      ItemListView.ItemIndex := Sel.Index;
      ItemListView.Selected;
      if PageControl.TabIndex = 0 then
        ItemListView.SetFocus;
      for I := 0 to ItemListView.Items.Count - 1 do
      begin
        ItemStr := Copy(ItemListView.Items[I].Caption,
          Pos('.', ItemListView.Items[I].Caption) + 1,
          Length(ItemListView.Items[I].Caption));
        ItemListView.Items[I].Caption := IntToStr(I + 1) + '. ' + ItemStr;
      end;
      LoadMatrix;
      LoadCharacterList;
      FileIsChanged := True;
      SaveBtn.Enabled := True;
      UpdateTitleBar(OpenDialog.FileName);
    end;
  end;
end;

procedure TMainForm.EditDeleteCharacterItemClick(Sender: TObject);
var
  CharIndex, J: integer;
begin
  CharIndex := CharacterListView.ItemIndex;
  if CharIndex >= 0 then
  begin
    CharacterListView.Items.Delete(CharIndex);
    DeleteOneCharacter(Dataset.CharacterList, CharIndex);
    for J := 0 to Length(Dataset.CharacterList) - 1 do
    try
      Dataset.CharacterList[J].charStates.Delete(CharIndex);
    except
      break;
    end;
    LoadCharacterList;
    DataMatrix.DeleteCol(CharIndex + 1);
    DataMatrix.Refresh;
    FileIsChanged := True;
    SaveBtn.Enabled := True;
    UpdateMenuItems(Self);
    UpdateStatusBar(Self);
    UpdateTitleBar(OpenDialog.FileName);
    CharacterListView.ItemIndex := CharIndex - 1;
    CharacterListView.Selected;
    if PageControl.TabIndex = 0 then
      CharacterListView.SetFocus;
  end;
end;

procedure TMainForm.EditDeleteItemClick(Sender: TObject);
var
  ItemIndex: integer;
begin
  ItemIndex := ItemListView.ItemIndex;
  if ItemIndex >= 0 then
  begin
    ItemListView.Items.Delete(ItemIndex);
    DeleteOneItem(Dataset.ItemList, ItemIndex);
    LoadItemList;
    DataMatrix.DeleteRow(ItemIndex + 1);
    DataMatrix.Refresh;
    LoadCharacterList;
    FileIsChanged := True;
    SaveBtn.Enabled := True;
    UpdateMenuItems(Self);
    UpdateStatusBar(Self);
    UpdateTitleBar(OpenDialog.FileName);
    ItemListView.ItemIndex := ItemIndex - 1;
    ItemListView.Selected;
    if PageControl.TabIndex = 0 then
      ItemListView.SetFocus;
  end;
end;

procedure TMainForm.EditDescriptionItemClick(Sender: TObject);
begin
  if DescriptionForm.ShowModal = mrOk then
  begin
    DataMatrix.Refresh;
    LoadCharacterList;
  end;
end;

procedure TMainForm.EditInsertCharacterItemClick(Sender: TObject);
var
  Character: Delta.TCharacter;
  CharName, CharType, CharUnit, CharNote, Rule: string;
  CharImplicit, I, J, N: integer;
  StatesList: TStringList;
  Selected: TListItem;
begin
  Selected := CharacterListView.Selected;
  if Assigned(Selected) then
  begin
    if (Selected.Index >= 0) then
    begin
      with CharacterForm do
      begin
        CharNumber := Length(Dataset.CharacterList) + 1;
        Caption := strAddCharacter;
        EditChar.Text := '';
        EditNote.Lines.Clear;
        rbUM.Checked := True;
        rbOM.Checked := False;
        rbIN.Checked := False;
        rbRN.Checked := False;
        rbTE.Checked := False;
        ListStates.Clear;
        CheckImplicit.Checked := False;
        EditUnit.Text := '';
        StateImplicit := 0;
      end;
      if CharacterForm.ShowModal = mrOk then
      begin
        with CharacterForm do
        begin
          CharName := EditChar.Text;
          CharNote := EditNote.Lines.Text;
          if not IsEmptyStr(CharName, [' ']) then
          begin
            if rbUM.Checked then
              CharType := 'UM'
            else if rbOM.Checked then
              CharType := 'OM'
            else if rbIN.Checked then
              CharType := 'IN'
            else if rbRN.Checked then
              CharType := 'RN'
            else if rbTE.Checked then
              CharType := 'TE';
            if (CharType = 'UM') or (CharType = 'OM') then
            begin
              if ListStates.Items.Count > 0 then
              begin
                StatesList := TStringList.Create;
                StatesList.Assign(ListStates.Items);
              end;
            end;
            if (CharType = 'IN') or (CharType = 'RN') then
              CharUnit := EditUnit.Text;
            if EditNote.Lines.Count > 0 then
              CharNote := EditNote.Text;
            if StateImplicit > 0 then
              CharImplicit := StateImplicit;
            Character.charName := CharName;
            Character.charType := CharType;
            Character.charUnit := CharUnit;
            Character.charImplicit := CharImplicit;
            Character.charNote := CharNote;
            Character.charStates := StatesList;
            Character.charDependent := DependentChar;
            InsertOneCharacter(Dataset.CharacterList, Selected.Index, Character);
            for J := 0 to Length(Dataset.ItemList) - 1 do
              Dataset.ItemList[J].itemAttributes.Insert(Selected.Index, 'U');
            LoadCharacterList;
            LoadMatrix;
            FileIsChanged := True;
            SaveBtn.Enabled := True;
            UpdateTitleBar(OpenDialog.FileName);
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.EditInsertItemClick(Sender: TObject);
var
  ItemStr, ItemName, ItemComment, TempStr: string;
  J: integer;
  Item: Delta.TItem;
  Selected: TListItem;
begin
  TempStr := StatusLine.SimpleText;
  StatusLine.SimpleText := strItemStatus;
  Selected := ItemListView.Selected;
  if Assigned(Selected) then
  begin
    if Selected.Index >= 0 then
    begin
      ItemStr := InputBox(strAddItemCaption, strAddItemPrompt, '');
      if not IsEmptyStr(ItemStr, [' ']) then
      begin
        if Pos('<', ItemStr) > 0 then
        begin
          ItemName := Trim(Copy(ItemStr, 1, Pos('<', ItemStr) - 1));
          ItemComment := Copy(ItemStr, Pos('<', ItemStr), Pos('>', ItemStr));
        end
        else
        begin
          ItemName := ItemStr;
          ItemComment := '';
        end;
        Item.itemName := ItemName;
        Item.itemComment := ItemComment;
        Item.itemAttributes := TStringList.Create;
        for J := 0 to Length(Dataset.CharacterList) - 1 do
          Item.itemAttributes.Add('U');
        InsertOneItem(Dataset.ItemList, Selected.Index, Item);
        LoadItemList;
        LoadMatrix;
        LoadCharacterList(Selected.Index);
        FileIsChanged := True;
        SaveBtn.Enabled := True;
        UpdateTitleBar(OpenDialog.FileName);
        ItemListView.Selected := ItemListView.Items[Selected.Index];
      end;
    end;
  end;
  StatusLine.SimpleText := TempStr;
end;

procedure TMainForm.EditMergeCharacterItemClick(Sender: TObject);
var
  CurDir, Directory: string;
  NChars, NSpecs, I, K: integer;
  hasSpecs: boolean;
  ADataset: TDelta;
  ACharacter: Delta.TCharacter;
begin
  SelectDirectoryDialog.Filename := '';
  if SelectDirectoryDialog.Execute then
  begin
    Directory := SelectDirectoryDialog.Filename;
    GetDir(0, CurDir);
    ChDir(Directory);
    if not FileExists('chars') then
    begin
      MessageDlg(strInformation, Format(strNotFoundDir, ['CHARS', Directory]),
        mtInformation, [mbOK], 0);
      Exit;
    end;
    if not FileExists('specs') then
    begin
      MessageDlg(strInformation, Concat(Format(strNotFoundDir, ['SPECS', Directory]),
        LineEnding, strMerge), mtInformation, [mbOK], 0);
      hasSpecs := False;
    end
    else
      hasSpecs := True;
    ADataset := TDelta.Create;
    NChars := ADataset.ReadChars('chars');
    if (NChars < 0) then
    begin
      MessageDlg(strError, Format(strReadError, ['CHARS', Directory]),
        mtError, [mbOK], 0);
      ADataset.Free;
      Exit;
    end;
    if hasSpecs then
    begin
      NSpecs := ADataset.ReadSpecs('specs', typeDirective);
      if (NSpecs < 0) then
      begin
        MessageDlg(strInformation, Format(strReadError, ['SPECS', Directory]),
          mtInformation, [mbOK], 0);
        Exit;
      end;
    end;
    K := Length(Dataset.CharacterList);
    for I := 0 to Length(ADataset.CharacterList) - 1 do
    begin
      ACharacter := ADataset.CharacterList[I];
      if not hasSpecs then
        ACharacter.charType := 'UM';
      InsertOneCharacter(Dataset.CharacterList, K, ACharacter);
      Inc(K);
    end;
    WriteDelta(Dataset, 'chars_new', 'items_new', 'specs_new');
    Screen.Cursor := crHourGlass;
    Dataset := Delta.ReadDelta('chars_new', 'items_new', 'specs_new');
    LoadItemList;
    LoadCharacterList;
    LoadMatrix;
    Screen.Cursor := crDefault;
    if PageControl.TabIndex = 0 then
      CharacterListView.SetFocus;
    ChDir(CurDir);
    FileIsChanged := True;
    SaveBtn.Enabled := True;
    UpdateTitleBar(OpenDialog.FileName);
    ADataset.Free;
    DeleteFile('chars_new');
    DeleteFile('items_new');
    DeleteFile('specs_new');
  end;
end;

procedure TMainForm.EditScriptItemClick(Sender: TObject);
begin
  ScriptForm.ShowModal;
end;

end.

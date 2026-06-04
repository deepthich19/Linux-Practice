# Day 2 - File Management

## Creating Files and Folders
```
touch file.txt                        # create empty file
touch file2.txt file3.txt             # create multiple at once
mkdir folder                          # create folder
mkdir folder1 folder2 folder3         # create multiple at once
mkdir -p parent/child/grandchild      # create nested folders
```

## Copying
```
cp file1.txt file2.txt                # copy file
cp file1.txt myfolder/                # copy file to another folder
cp -r folder1 folder2                 # copy folder recursively
```

## Moving and Renaming
```
mv file1.txt folder/                  # move file
mv old.txt new.txt                    # rename file
mv folder1 folder2                    # move folder
```

## Deleting
```
rm file.txt                           # delete file
rm file1.txt file2.txt                # delete multiple files
rm -r folder                          # delete folder
rm -rf folder                         # force delete
```

## Viewing File Contents
```
cat - Dumps entire file content at once — scrolls past if file is long. less - Opens file in a reader — you scroll through it at your own pace.
cat file.txt                          # print entire file
less file.txt                         # page by page, q to quit
head -n 5 file.txt                    # first 5 lines
tail -n 5 file.txt                    # last 5 lines
```

## Finding Files
```
find / -name "file1.txt"	      # Search from root
find ~ -name "*.txt"                  # find by extension
find ~ -type f -name "file"           # find files only
find ~ -type d -name "folder"         # find folders only
find . -name "file1.txt"              # find in current folder
find ~ -type f -name "*.md"	      # Find files only
```

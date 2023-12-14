import glob, os

# directory_prefix = 'run1/structures/it1/water/'

## Create list of files to keep
files_to_keep = [
    'run1/haddock.out'
]

## Add in all results from water iteration
for filename in glob.glob("run1/structures/it1/water/*"):
    files_to_keep.append(filename)

## Remove files not in "to keep" list
for root, dirs, files in os.walk('run1'):
    for file in files:
        file_path = os.path.join(root, file)
        if file_path not in files_to_keep:
            # print(f'- Removing: {file_path}')
            print('- Removing: ' + file_path)
            os.remove(file_path)
        else:
            # print(f'+ Keeping: {file_path}')
            print('+ Keeping: ' + file_path)

## Clean up empty folders
for folder, _, _ in list(os.walk('run1'))[::-1]:
    if len(os.listdir(folder)) == 0:
        # print(f'- Removing Folder: {folder}')
        print('- Removing Folder: ' + folder)
        os.rmdir(folder)
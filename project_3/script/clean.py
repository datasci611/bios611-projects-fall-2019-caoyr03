import pandas as pd
# Read in the dataset
client = pd.read_csv('data/CLIENT_191102.tsv',sep = '\t')
condition = pd.read_csv('data/EE_UDES_191102.tsv',sep = '\t')
exit = pd.read_csv('data/ENTRY_EXIT_191102.tsv',sep = '\t')
# Clean the dataset
client.drop(['EE Provider ID','Client ID'],inplace=True, axis = 1)
condition.drop(['EE Provider ID','Entry Exit Provider Program Type Code','Client ID','Client Location(4378)','Zip Code (of Last Permanent Address, if known)(1932)','Relationship to Head of Household(4374)','Did you stay less than 7 nights?(5164)','Did you stay less than 90 days?(5163)','On the night before did you stay on the streets, ES or SH?(5165)','If yes for Domestic violence victim/survivor, when experience occurred(1917)'],inplace=True, axis = 1)
exit.drop(['EE Provider ID','Client ID','Entry Exit Group Id','Entry Exit Household Id','Housing Move-in Date(5584)','Entry Exit Date Added','Entry Exit Date Updated','Entry Exit Type'],axis=1)
exit.drop(exit.columns[2], axis=1, inplace=True)
# Combine the dataset
combined = pd.merge(client, condition, on = ['EE UID'])
combined = pd.merge(combined, exit, on =['EE UID']).drop(['Client Unique ID_x','Client Unique ID_y'],axis=1)
combined.columns
# Wrangle the data: Remove the (HUD) from records tails
combined['Client Primary Race'] = combined['Client Primary Race'].str.slice(0,-5)
combined['Client Ethnicity'] = combined['Client Ethnicity'].str.slice(0,-5)
combined['Client Veteran Status'] = combined['Client Veteran Status'].str.slice(0,-5)
combined['Does the client have a disabling condition?(1935)'] = combined['Does the client have a disabling condition?(1935)'].str.slice(0,-5)
combined['Regardless of where they stayed last night - Number of times the client has been on the streets, in ES, or SH in the past three years including today(5167)'] = combined['Regardless of where they stayed last night - Number of times the client has been on the streets, in ES, or SH in the past three years including today(5167)'].str.slice(0,-5)
combined['Covered by Health Insurance(4376)'] = combined['Covered by Health Insurance(4376)'].str.slice(0,-5)
combined['Domestic violence victim/survivor(341)'] = combined['Domestic violence victim/survivor(341)'].str.slice(0,-5)
combined['Housing Status(2703)'] = combined['Housing Status(2703)'].str.slice(0,-5)
combined.head()
combined.columns = ['EEUID','Age_entry','Age_exit','Gender','Race','Ethnicity','Veteran','LivingSituation','LengthStayPrevious','TimesHomeless','LengthHomeless','HousingStatus','Disability','HealthInsurance','ViolanceVictim','DOB','ClientID','Entrydate','Exitdate','Destination','Reason']
combined.to_csv('../data/wrangle_data.csv')

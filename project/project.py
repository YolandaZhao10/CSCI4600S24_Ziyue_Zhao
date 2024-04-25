import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
from sklearn.svm import SVR
from sklearn.preprocessing import StandardScaler
from statsmodels.tsa.seasonal import STL
from statsmodels.tsa.ar_model import AutoReg
from statsmodels.tsa.arima.model import ARIMA
from statsmodels.tsa.stattools import adfuller
from sklearn.neighbors import KNeighborsRegressor
from sklearn.model_selection import train_test_split
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

# read .csv file
point1_result = np.genfromtxt('point1_result.csv', delimiter=',')
point2_result = np.genfromtxt('point2_result.csv', delimiter=',')
point3_result = np.genfromtxt('point3_result.csv', delimiter=',')
point4_result = np.genfromtxt('point4_result.csv', delimiter=',')

points = [point1_result, point2_result, point3_result, point4_result]
dates = pd.Series(
        list(point1_result), index = pd.date_range('27-2-2022', periods=len(list(point1_result)), freq='D'))

# plot the precipitation data for the specific locations
plt.plot(dates.index,point1_result, label='lat: 35.0625, lon: -115.9375')
plt.plot(dates.index,point2_result, label='lat: 40.0625, lon: -80.0625')
plt.plot(dates.index,point3_result, label='lat: 52.9375, lon: -67.0625')
plt.plot(dates.index,point4_result, label='lat: 52.9375, lon: -115.9375')
plt.xlabel('Time')
plt.ylabel('Precipitation')
plt.legend()
plt.title('Precipitation data for specific locations')
plt.savefig('./raw_graph/precipitation.png')
plt.close()


# plot the histogram of the precipitation data for the specific locations
# each location in a separate subplot
x = []
p = []
for i in range(4):
    data = points[i]
    mu, std = stats.norm.fit(data)
    x.append(np.linspace(data.min(), data.max(), 100))
    p.append(stats.norm.pdf(x[i], mu, std))
  
fig, axs = plt.subplots(2, 2)
axs[0, 0].hist(point1_result, bins=10, density=True)
axs[0, 0].plot(x[0], p[0], 'k', linewidth=2)
axs[0, 0].set_title('lat: 35.0625, lon: -115.9375')
axs[0, 0].set_ylabel('Frequency')
axs[0, 0].set_xlabel('Precipitation')
axs[0, 1].hist(point2_result, bins=10, density=True)
axs[0, 1].plot(x[1], p[1], 'k', linewidth=2)
axs[0, 1].set_title('lat: 40.0625, lon: -80.0625')
axs[0, 1].set_ylabel('Frequency')
axs[0, 1].set_xlabel('Precipitation')
axs[1, 0].hist(point3_result, bins=10, density=True)
axs[1, 0].plot(x[2], p[2], 'k', linewidth=2)
axs[1, 0].set_title('lat: 52.9375, lon: -67.0625')
axs[1, 0].set_ylabel('Frequency')
axs[1, 0].set_xlabel('Precipitation')
axs[1, 1].hist(point4_result, bins=10, density=True)
axs[1, 1].plot(x[3], p[3], 'k', linewidth=2)
axs[1, 1].set_title('lat: 52.9375, lon: -115.9375')
axs[1, 1].set_ylabel('Frequency')
axs[1, 1].set_xlabel('Precipitation')

plt.tight_layout()
plt.savefig('./raw_graph/histogram_precipitation.png')
plt.close()


# try to predict the precipitation data for the specific location
max_lag = 10
n_lags = 200

# shapiro_test for the precipitation data for the specific locations
for i in range(4):
    print(f"Point {i+1} results:")
    mean = np.mean(points[i])
    std = np.std(points[i])
    print(f"\tDescriptive statistics:")
    print(f"\t\tMean: {mean}")
    print(f"\t\tStandard Deviation: {std}")
    IQR = stats.iqr(points[i])
    print(f"\t\tInterquartile Range: {IQR}")
    skew = stats.skew(points[i])
    print(f"\t\tSkewness: {skew}")
    print()

    result = stats.shapiro(points[i])
    print(f"\tShapiro test result:")
    print(f'\t\tStatistic: {result[0]}')
    print(f'\t\tp-value: {result[1]}')
    if result[1] > 0.05:
        print('\t\tThe data is normally distributed')
    else:
        print('\t\tThe data is not normally distributed')
    print()
  
# https://scikit-learn.org/stable/modules/generated/sklearn.svm.SVR.html
# do SVR on the precipitation data for the specific location
    features = np.array([points[i][j:(j + n_lags)] for j in range(len(points[i]) - n_lags)])
    target = points[i][n_lags:]
    X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    svr = SVR(kernel='rbf', C=1.0, epsilon=0.1)
    svr.fit(X_train_scaled, y_train)
    predictions = svr.predict(X_test_scaled)
    plt.plot(y_test, label='Actual')
    plt.plot(predictions, color='red', label='Predicted')
    plt.title(f'SVR on the precipitation data for point {i+1}')
    plt.xlabel('Time')
    plt.ylabel('Precipitation')
    plt.legend()
    plt.savefig(f'./svr_graph/SVR_point{i+1}.png')
    plt.close()
    mse = mean_squared_error(y_test, predictions)
    r2 = r2_score(y_test, predictions)
    print(f'\tSVR result:')
    print(f'\t\tMean Squared Error: {mse}')
    print(f'\t\tR2 Score: {r2}')
    print()


# https://realpython.com/knn-python/
# do KNN regression on the precipitation data for the specific location
    features = np.array([points[i][j:(j + n_lags)] for j in range(len(points[i]) - n_lags)])
    target = points[i][n_lags:]
    X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)
    knn = KNeighborsRegressor(n_neighbors=5)
    knn.fit(X_train, y_train)
    predictions = knn.predict(X_test)
    plt.plot(y_test, label='Actual')
    plt.plot(predictions, color='red', label='Predicted')
    plt.title(f'KNN regression on the precipitation data for point {i+1}')
    plt.xlabel('Time')
    plt.ylabel('Precipitation')
    plt.legend()
    plt.savefig(f'./knn_graph/KNN_point{i+1}.png')
    plt.close()
    mse = mean_squared_error(y_test, predictions)
    r2 = r2_score(y_test, predictions)
    print(f'\tKNN regression result:')
    print(f'\t\tMean Squared Error: {mse}')
    print(f'\t\tR2 Score: {r2}')
    print()


# https://www.statsmodels.org/devel/generated/statsmodels.tsa.seasonal.STL.html
# find trend, senasonality and residuals of the precipitation data for the specific location
    data = pd.Series(
        list(points[i]), index = pd.date_range('27-2-2022', periods=len(list(points[i])), freq='D')
    )
    stl = STL(data, seasonal=13)
    res = stl.fit()
    res.plot()
    plt.title(f'Trend, Senasonality and Residuals of the precipitation data for point {i+1}') 
    plt.savefig(f'./raw_graph/trend_point{i+1}.png')
    plt.close()


# split the data into training and testing data
    data = pd.Series(
        list(points[i]), index = pd.date_range('27-2-2022', periods=len(list(points[i])), freq='D')
    )
    train, test = points[i][:int(len(data)*0.6)], points[i][int(len(data)*0.6):]
    train_dates, test_dates = dates.index[0:int(len(points[i])*0.6)], dates.index[int(len(points[i])*0.6):]

# https://www.statsmodels.org/stable/generated/statsmodels.tsa.ar_model.AutoReg.html
# Do auto regression on the precipitation data for the specific location
    print(f'\tAuto regression model result:')
    ans = points[i] - res.trend - res.seasonal
    train, test = ans[:int(len(data)*0.6)], ans[int(len(data)*0.6):]
    result = []
    for j in range(1, max_lag+1):
        model = AutoReg(train, lags=j)
        model_fit = model.fit()
        result.append({
            'lag': j,
            'aic': model_fit.aic,
            'bic': model_fit.bic
        })
    result = pd.DataFrame(result)
    best_aic_lag = result.loc[result['aic'].idxmin(), 'lag']
    best_model = AutoReg(train, lags=best_aic_lag).fit()
    predictions = model_fit.predict(start=len(train), end=len(train)+len(test)-1, dynamic=False)
    trend_seasonality = res.trend + res.seasonal
    train_trend_seasonality, test_trend_seasonality = trend_seasonality[:int(len(data)*0.6)], trend_seasonality[int(len(data)*0.6):]
    predictions = predictions + test_trend_seasonality
    test = test + test_trend_seasonality
    plt.plot(test_dates,test, label='Actual')
    plt.plot(test_dates,predictions, color='red', label='Predicted')
    plt.title(f'Auto regression on the precipitation data for point {i+1}')
    plt.xlabel('Time')
    plt.ylabel('Precipitation')
    plt.text(1, 1, f'lag {best_aic_lag}(aic: {int(model_fit.aic)})')
    plt.legend()
    plt.savefig(f'./ar_graph/AR_point{i+1}.png')
    plt.close()

    # calculate the error
    mse = mean_squared_error(test, predictions)
    print(f'\t\tMean Squared Error for point {i+1}: {mse}')
    mae = mean_absolute_error(test, predictions)
    print(f'\t\tMean Absolute Error for point {i+1}: {mae}')
    rmse = np.sqrt(mse)      
    print(f'\t\tRoot Mean Squared Error for point {i+1}: {rmse}')
    print()


# Do ARIMA on the precipitation data for the specific location
# https://www.kdnuggets.com/2023/08/times-series-analysis-arima-models-python.html
    print(f'\tARIMA model result:')
    plot_acf(points[i])
    plt.title(f'ACF plot for point {i+1}')
    plt.savefig(f'./arima_graph/ACF_point{i+1}.png')
    plt.close()
    plot_pacf(points[i])
    plt.title(f'PACF plot for point {i+1}')
    plt.savefig(f'./arima_graph/PACF_point{i+1}.png')
    plt.close()

    # base on these plots, we will use ARIMA(1, 1, 1) model
    ans = points[i] - res.trend - res.seasonal
    train, test = ans[:int(len(data)*0.6)], ans[int(len(data)*0.6):]
    model = ARIMA(train, order=(1, 1, 1))
    model_fit = model.fit()
    predictions = model_fit.forecast(steps=len(test))
    trend_seasonality = res.trend + res.seasonal
    train_trend_seasonality, test_trend_seasonality = trend_seasonality[:int(len(data)*0.6)], trend_seasonality[int(len(data)*0.6):]
    predictions = predictions + test_trend_seasonality
    test = test + test_trend_seasonality
    plt.plot(test_dates,test, label='Actual')
    plt.plot(test_dates,predictions, color='red', label='Predicted')
    plt.title(f'ARIMA on the precipitation data for point {i+1}')
    plt.xlabel('Time')
    plt.ylabel('Precipitation')
    plt.legend()
    plt.savefig(f'./arima_graph/ARIMA_point{i+1}.png')
    plt.close()

    # calculate the error
    mse = mean_squared_error(test, predictions)
    print(f'\t\tMean Squared Error for point {i+1}: {mse}')
    mae = mean_absolute_error(test, predictions)
    print(f'\t\tMean Absolute Error for point {i+1}: {mae}')
    rmse = np.sqrt(mse)      
    print(f'\t\tRoot Mean Squared Error for point {i+1}: {rmse}')
    print()
    



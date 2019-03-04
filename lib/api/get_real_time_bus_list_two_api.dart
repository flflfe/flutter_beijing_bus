import '../include.dart';
import 'base_api.dart';
import '../bean/real_time_bus_bean.dart';
export '../bean/real_time_bus_bean.dart';
export '../bean/get_real_time_bus_req_two_bean.dart';

class GetRealTimeBusListTwoApi extends RealTimeBaseApi<List<RealTimeBusBean>> {
  GetRealTimeBusListTwoApi(BuildContext context) : super(context);

  @override
    String apiMethod(Map<String, dynamic> params) {
    return "/ssgj/bus2.php?query=" + params['query'] + '&encrypt=1&datatype=json';
  }

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  List<RealTimeBusBean> onExtractResult(resultData, HttpData<List<RealTimeBusBean>> data) {
    List resultList = resultData;
    return resultList.map((item) {
      RealTimeBusBean realTimeBusBean = RealTimeBusBean.fromJson(item);
      realTimeBusBean.decode();
      return realTimeBusBean;
    }).toList();
  }

  @override
  List<RealTimeBusBean> onResponseSuccess(response, HttpData<List<RealTimeBusBean>> data) {
    if (response['root']['data'] == null || response['root']['data']['bus'] == null) {
      return [];
    }
    return onExtractResult(response['root']['data']['bus'], data);
  }
}

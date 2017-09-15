#ifndef _HTTP_UTILS_H_
#define _HTTP_UTILS_H_

#include <string>
#include <mutex>
#include <memory>
#include <map>

class CCurlHandleManager;
class CCurlWrapper;

class CHttpUtils
{
public:
	static void init();
	static void cleanup();
	static std::string postRequestSync(const std::string& url, const std::string& data, const int timeout, std::string requestId);
	static std::string getRequestSync(const std::string& url, const int timeout, std::string requestId);
	static std::string postRequestWithJSON(const std::string& url, const std::map<std::string, std::string>& keyValue, const int timeout, const std::string& requestId, std::map<std::string, std::string>& httpResponseHeader);
	static void stopRequest(const std::string& requestId);

private:
	static const int NORMAL_TIME_OUT = 16;
	static const int PUSH_TIME_OUT = 30;
	static CCurlHandleManager* _manager;
	static std::mutex _mutex;
	static std::map<std::string, std::shared_ptr<CCurlWrapper>> _request_map;
	static std::string uuid();
	static void addRequest(const std::string& requestId, std::shared_ptr<CCurlWrapper> curlWrapper);
	static void removeRequest(const std::string& requestId);
};

#endif // !_HTTP_UTILS_H_

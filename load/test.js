import { check } from "k6";
import http from "k6/http";

export const options = {
  vus: 10,
  duration: "20s",
};

export default function () {
  const res = http.get(`http://${__ENV.LB_PUBLIC_IP}/hello`);
  check(res, {
    "Is 200 OK": (r) => r.status === 200,
    "Valid Response": (r) => r.body.includes("Hello"),
  });
}
